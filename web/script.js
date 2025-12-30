// Persian alphabet (50 characters for Base-50 encoding)
const PERSIAN_ALPHABET = 'ابپتثجچحخدذرزژسشصضطظعغفقکگلمنوهیآأإؤئة۰۱۲۳۴۵۶۷۸۹';

// Master seed for default encryption (when no password provided)
const MASTER_SEED = 'SecurePersianLinkEncoder2025DefaultKey!';

// Switch between tabs
function switchTab(tab) {
  document
    .querySelectorAll('.tab')
    .forEach((t) => t.classList.remove('active'));
  document
    .querySelectorAll('.tab-content')
    .forEach((t) => t.classList.remove('active'));

  if (tab === 'encrypt') {
    document.querySelectorAll('.tab')[0].classList.add('active');
    document.getElementById('encrypt-tab').classList.add('active');
  } else {
    document.querySelectorAll('.tab')[1].classList.add('active');
    document.getElementById('decrypt-tab').classList.add('active');
  }
}

// Toggle password visibility
function togglePassword() {
  const input = document.getElementById('password-input');
  input.type = input.type === 'password' ? 'text' : 'password';
}

function toggleDecryptPassword() {
  const input = document.getElementById('decrypt-password-input');
  input.type = input.type === 'password' ? 'text' : 'password';
}

// Show notification
function showNotification(message, isError = false) {
  const notification = document.getElementById('notification');
  notification.textContent = message;
  notification.className = 'notification show' + (isError ? ' error' : '');
  setTimeout(() => {
    notification.classList.remove('show');
  }, 3000);
}

// Copy to clipboard
function copyToClipboard(elementId) {
  const element = document.getElementById(elementId);
  if (!element.value) {
    showNotification('Nothing to copy!', true);
    return;
  }
  element.select();
  document.execCommand('copy');
  showNotification('✅ Copied to clipboard!');
}

// Open decrypted URL
function openURL() {
  const url = document.getElementById('decrypted-output').value;
  if (!url) {
    showNotification('No URL to open!', true);
    return;
  }
  window.open(url, '_blank');
}

// Reset functions
function resetEncrypt() {
  document.getElementById('url-input').value = '';
  document.getElementById('password-input').value = '';
  document.getElementById('encrypted-output').value = '';
}

function resetDecrypt() {
  document.getElementById('persian-input').value = '';
  document.getElementById('decrypt-password-input').value = '';
  document.getElementById('decrypted-output').value = '';
}

// Derive key from password using PBKDF2
async function deriveKey(password, salt) {
  const encoder = new TextEncoder();
  const passwordKey = await crypto.subtle.importKey(
    'raw',
    encoder.encode(password || MASTER_SEED),
    'PBKDF2',
    false,
    ['deriveBits', 'deriveKey']
  );

  return crypto.subtle.deriveKey(
    {
      name: 'PBKDF2',
      salt: salt,
      iterations: 100000,
      hash: 'SHA-256',
    },
    passwordKey,
    { name: 'AES-GCM', length: 256 },
    false,
    ['encrypt', 'decrypt']
  );
}

// Convert bytes to Persian text (Base-50 encoding)
function bytesToPersian(bytes) {
  let result = '';
  const base = PERSIAN_ALPHABET.length;

  // Convert bytes to big integer
  let num = 0n;
  for (let i = 0; i < bytes.length; i++) {
    num = (num << 8n) | BigInt(bytes[i]);
  }

  // Convert to base-50
  if (num === 0n) {
    return PERSIAN_ALPHABET[0];
  }

  while (num > 0n) {
    result = PERSIAN_ALPHABET[Number(num % BigInt(base))] + result;
    num = num / BigInt(base);
  }

  return result;
}

// Convert Persian text back to bytes
function persianToBytes(persian) {
  const base = PERSIAN_ALPHABET.length;
  let num = 0n;

  for (let i = 0; i < persian.length; i++) {
    const digit = PERSIAN_ALPHABET.indexOf(persian[i]);
    if (digit === -1) {
      throw new Error('Invalid Persian character');
    }
    num = num * BigInt(base) + BigInt(digit);
  }

  // Convert big integer back to bytes
  const bytes = [];
  let tempNum = num;
  while (tempNum > 0n) {
    bytes.unshift(Number(tempNum & 0xffn));
    tempNum = tempNum >> 8n;
  }

  return new Uint8Array(bytes);
}

// Encrypt URL
async function encryptURL() {
  try {
    const url = document.getElementById('url-input').value.trim();
    const password = document.getElementById('password-input').value;

    if (!url) {
      showNotification('Please enter a URL!', true);
      return;
    }

    // Validate URL
    try {
      new URL(url);
    } catch (e) {
      showNotification('Invalid URL format!', true);
      return;
    }

    // Generate salt and IV
    const salt = crypto.getRandomValues(new Uint8Array(16));
    const iv = crypto.getRandomValues(new Uint8Array(12));

    // Derive key
    const key = await deriveKey(password, salt);

    // Encrypt
    const encoder = new TextEncoder();
    const encrypted = await crypto.subtle.encrypt(
      { name: 'AES-GCM', iv: iv },
      key,
      encoder.encode(url)
    );

    // Format: [version:1byte][salt:16bytes][iv:12bytes][ciphertext][authTag:16bytes]
    const version = new Uint8Array([1]);
    const ciphertext = new Uint8Array(encrypted);

    const combined = new Uint8Array(
      version.length + salt.length + iv.length + ciphertext.length
    );
    combined.set(version, 0);
    combined.set(salt, version.length);
    combined.set(iv, version.length + salt.length);
    combined.set(ciphertext, version.length + salt.length + iv.length);

    // Convert to Persian
    const persianText = bytesToPersian(combined);
    document.getElementById('encrypted-output').value = persianText;

    showNotification('✅ URL encrypted successfully!');
  } catch (error) {
    console.error('Encryption error:', error);
    showNotification('❌ Encryption failed: ' + error.message, true);
  }
}

// Decrypt URL
async function decryptURL() {
  try {
    const persianText = document.getElementById('persian-input').value.trim();
    const password = document.getElementById('decrypt-password-input').value;

    if (!persianText) {
      showNotification('Please enter Persian text!', true);
      return;
    }

    // Convert Persian to bytes
    const combined = persianToBytes(persianText);

    // Parse components
    const version = combined[0];
    if (version !== 1) {
      throw new Error('Unsupported version');
    }

    const salt = combined.slice(1, 17);
    const iv = combined.slice(17, 29);
    const ciphertext = combined.slice(29);

    // Derive key
    const key = await deriveKey(password, salt);

    // Decrypt
    const decrypted = await crypto.subtle.decrypt(
      { name: 'AES-GCM', iv: iv },
      key,
      ciphertext
    );

    const decoder = new TextDecoder();
    const url = decoder.decode(decrypted);

    document.getElementById('decrypted-output').value = url;
    showNotification('✅ URL decrypted successfully!');
  } catch (error) {
    console.error('Decryption error:', error);
    showNotification(
      '❌ Decryption failed! Wrong password or corrupted data.',
      true
    );
  }
}
