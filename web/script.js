// Persian alphabet
const PERSIAN_ALPHABET = 'ابپتثجچحخدذرزژسشصضطظعغفقکگلمنوهیآأإؤئة۰۱۲۳۴۵۶۷۸۹';
const MASTER_SEED = 'SecurePersianLinkEncoder2025DefaultKey!';

// Language translations
const translations = {
  en: {
    mainTitle: '🔐 Secure Persian Link Encoder',
    subtitle: 'Encrypt URLs into Persian text - Fully Offline & Secure',
    tabEncrypt: '🔒 Encrypt',
    tabDecrypt: '🔓 Decrypt',
    labelUrl: '🔗 URL to Encrypt:',
    labelPassword: '🔑 Password (Optional):',
    labelShowPass: 'Show password',
    btnEncrypt: '🔒 Encrypt',
    btnResetEnc: '🔄 Reset',
    labelEncrypted: '📄 Encrypted Persian Text:',
    btnCopyEnc: '📋 Copy',
    infoEncrypt:
      'ℹ️ <strong>Info:</strong> Without password, anyone with this tool can decrypt. With password, only those who know it can decrypt.',
    labelPersian: '📄 Persian Text to Decrypt:',
    labelDecryptPass: '🔑 Password (if used during encryption):',
    labelShowDecPass: 'Show password',
    btnDecrypt: '🔓 Decrypt',
    btnResetDec: '🔄 Reset',
    labelDecrypted: '🔗 Decrypted URL:',
    btnCopyDec: '📋 Copy',
    btnOpen: '🌐 Open URL',
    footerText:
      'Made with ❤️ | <a href="https://github.com" target="_blank">GitHub</a> | AES-256-GCM Encryption',
    placeholderUrl: 'https://example.com/path',
    placeholderPass: 'Leave empty for default encryption',
    placeholderEncrypted: 'Encrypted text will appear here...',
    placeholderPersian: 'Paste encrypted Persian text here...',
    placeholderDecryptPass: 'Leave empty if no password was used',
    placeholderDecrypted: 'Decrypted URL will appear here...',
    notifyCopied: '✅ Copied to clipboard!',
    notifyNothingCopy: 'Nothing to copy!',
    notifyNoUrl: 'No URL to open!',
    notifyEnterUrl: 'Please enter a URL!',
    notifyInvalidUrl: 'Invalid URL format!',
    notifyEncryptSuccess: '✅ URL encrypted successfully!',
    notifyEncryptFailed: '❌ Encryption failed: ',
    notifyEnterPersian: 'Please enter Persian text!',
    notifyDecryptSuccess: '✅ URL decrypted successfully!',
    notifyDecryptFailed:
      '❌ Decryption failed! Wrong password or corrupted data.',
  },
  fa: {
    mainTitle: '🔐 رمزنگار لینک امن فارسی',
    subtitle: 'رمزنگاری لینک‌ها به متن فارسی - کاملاً آفلاین و امن',
    tabEncrypt: '🔒 رمزنگاری',
    tabDecrypt: '🔓 رمزگشایی',
    labelUrl: '🔗 لینک برای رمزنگاری:',
    labelPassword: '🔑 رمز عبور (اختیاری):',
    labelShowPass: 'نمایش رمز عبور',
    btnEncrypt: '🔒 رمزنگاری کن',
    btnResetEnc: '🔄 پاک کردن',
    labelEncrypted: '📄 متن فارسی رمزشده:',
    btnCopyEnc: '📋 کپی',
    infoEncrypt:
      'ℹ️ <strong>توجه:</strong> بدون رمز عبور، هر کسی با این ابزار می‌تواند رمزگشایی کند. با رمز عبور، فقط کسانی که آن را می‌دانند می‌توانند رمزگشایی کنند.',
    labelPersian: '📄 متن فارسی برای رمزگشایی:',
    labelDecryptPass: '🔑 رمز عبور (اگر هنگام رمزنگاری استفاده شده):',
    labelShowDecPass: 'نمایش رمز عبور',
    btnDecrypt: '🔓 رمزگشایی کن',
    btnResetDec: '🔄 پاک کردن',
    labelDecrypted: '🔗 لینک رمزگشایی‌شده:',
    btnCopyDec: '📋 کپی',
    btnOpen: '🌐 باز کردن لینک',
    footerText:
      'ساخته شده با ❤️ | <a href="https://github.com" target="_blank">گیت‌هاب</a> | رمزنگاری AES-256-GCM',
    placeholderUrl: 'https://example.com/path',
    placeholderPass: 'برای رمزنگاری پیش‌فرض خالی بگذارید',
    placeholderEncrypted: 'متن رمزشده اینجا نمایش داده می‌شود...',
    placeholderPersian: 'متن فارسی رمزشده را اینجا بچسبانید...',
    placeholderDecryptPass: 'اگر رمز استفاده نشده خالی بگذارید',
    placeholderDecrypted: 'لینک رمزگشایی‌شده اینجا نمایش داده می‌شود...',
    notifyCopied: '✅ در کلیپ‌بورد کپی شد!',
    notifyNothingCopy: 'چیزی برای کپی کردن نیست!',
    notifyNoUrl: 'لینکی برای باز کردن نیست!',
    notifyEnterUrl: 'لطفاً یک لینک وارد کنید!',
    notifyInvalidUrl: 'فرمت لینک نامعتبر است!',
    notifyEncryptSuccess: '✅ لینک با موفقیت رمزنگاری شد!',
    notifyEncryptFailed: '❌ رمزنگاری ناموفق بود: ',
    notifyEnterPersian: 'لطفاً متن فارسی وارد کنید!',
    notifyDecryptSuccess: '✅ لینک با موفقیت رمزگشایی شد!',
    notifyDecryptFailed:
      '❌ رمزگشایی ناموفق بود! رمز عبور اشتباه یا داده آسیب‌دیده است.',
  },
};

let currentLang = 'en';

// Switch language
function switchLanguage(lang) {
  currentLang = lang;
  const t = translations[lang];

  // Update text direction
  document.body.dir = lang === 'fa' ? 'rtl' : 'ltr';
  document.documentElement.lang = lang === 'fa' ? 'fa' : 'en';

  // Update button states
  document.querySelectorAll('.lang-btn').forEach((btn) => {
    btn.classList.remove('active');
  });
  event.target.classList.add('active');

  // Update all text
  document.getElementById('main-title').textContent = t.mainTitle;
  document.getElementById('subtitle').textContent = t.subtitle;
  document.getElementById('tab-encrypt').textContent = t.tabEncrypt;
  document.getElementById('tab-decrypt').textContent = t.tabDecrypt;
  document.getElementById('label-url').textContent = t.labelUrl;
  document.getElementById('label-password').textContent = t.labelPassword;
  document.getElementById('label-show-pass').textContent = t.labelShowPass;
  document.getElementById('btn-encrypt').textContent = t.btnEncrypt;
  document.getElementById('btn-reset-enc').textContent = t.btnResetEnc;
  document.getElementById('label-encrypted').textContent = t.labelEncrypted;
  document.getElementById('btn-copy-enc').textContent = t.btnCopyEnc;
  document.getElementById('info-encrypt').innerHTML = t.infoEncrypt;
  document.getElementById('label-persian').textContent = t.labelPersian;
  document.getElementById('label-decrypt-pass').textContent =
    t.labelDecryptPass;
  document.getElementById('label-show-dec-pass').textContent =
    t.labelShowDecPass;
  document.getElementById('btn-decrypt').textContent = t.btnDecrypt;
  document.getElementById('btn-reset-dec').textContent = t.btnResetDec;
  document.getElementById('label-decrypted').textContent = t.labelDecrypted;
  document.getElementById('btn-copy-dec').textContent = t.btnCopyDec;
  document.getElementById('btn-open').textContent = t.btnOpen;
  document.getElementById('footer-text').innerHTML = t.footerText;

  // Update placeholders
  document.getElementById('url-input').placeholder = t.placeholderUrl;
  document.getElementById('password-input').placeholder = t.placeholderPass;
  document.getElementById('encrypted-output').placeholder =
    t.placeholderEncrypted;
  document.getElementById('persian-input').placeholder = t.placeholderPersian;
  document.getElementById('decrypt-password-input').placeholder =
    t.placeholderDecryptPass;
  document.getElementById('decrypted-output').placeholder =
    t.placeholderDecrypted;
}

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

function togglePassword() {
  const input = document.getElementById('password-input');
  input.type = input.type === 'password' ? 'text' : 'password';
}

function toggleDecryptPassword() {
  const input = document.getElementById('decrypt-password-input');
  input.type = input.type === 'password' ? 'text' : 'password';
}

function showNotification(message, isError = false) {
  const notification = document.getElementById('notification');
  notification.textContent = message;
  notification.className = 'notification show' + (isError ? ' error' : '');
  setTimeout(() => {
    notification.classList.remove('show');
  }, 3000);
}

function copyToClipboard(elementId) {
  const t = translations[currentLang];
  const element = document.getElementById(elementId);
  if (!element.value) {
    showNotification(t.notifyNothingCopy, true);
    return;
  }
  element.select();
  document.execCommand('copy');
  showNotification(t.notifyCopied);
}

function openURL() {
  const t = translations[currentLang];
  const url = document.getElementById('decrypted-output').value;
  if (!url) {
    showNotification(t.notifyNoUrl, true);
    return;
  }
  window.open(url, '_blank');
}

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

function bytesToPersian(bytes) {
  let result = '';
  const base = PERSIAN_ALPHABET.length;

  let num = 0n;
  for (let i = 0; i < bytes.length; i++) {
    num = (num << 8n) | BigInt(bytes[i]);
  }

  if (num === 0n) {
    return PERSIAN_ALPHABET[0];
  }

  while (num > 0n) {
    result = PERSIAN_ALPHABET[Number(num % BigInt(base))] + result;
    num = num / BigInt(base);
  }

  return result;
}

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

  const bytes = [];
  let tempNum = num;
  while (tempNum > 0n) {
    bytes.unshift(Number(tempNum & 0xffn));
    tempNum = tempNum >> 8n;
  }

  return new Uint8Array(bytes);
}

async function encryptURL() {
  const t = translations[currentLang];
  try {
    const url = document.getElementById('url-input').value.trim();
    const password = document.getElementById('password-input').value;

    if (!url) {
      showNotification(t.notifyEnterUrl, true);
      return;
    }

    try {
      new URL(url);
    } catch (e) {
      showNotification(t.notifyInvalidUrl, true);
      return;
    }

    const salt = crypto.getRandomValues(new Uint8Array(16));
    const iv = crypto.getRandomValues(new Uint8Array(12));
    const key = await deriveKey(password, salt);

    const encoder = new TextEncoder();
    const encrypted = await crypto.subtle.encrypt(
      { name: 'AES-GCM', iv: iv },
      key,
      encoder.encode(url)
    );

    const version = new Uint8Array([1]);
    const ciphertext = new Uint8Array(encrypted);

    const combined = new Uint8Array(
      version.length + salt.length + iv.length + ciphertext.length
    );
    combined.set(version, 0);
    combined.set(salt, version.length);
    combined.set(iv, version.length + salt.length);
    combined.set(ciphertext, version.length + salt.length + iv.length);

    const persianText = bytesToPersian(combined);
    document.getElementById('encrypted-output').value = persianText;

    showNotification(t.notifyEncryptSuccess);
  } catch (error) {
    console.error('Encryption error:', error);
    showNotification(t.notifyEncryptFailed + error.message, true);
  }
}

async function decryptURL() {
  const t = translations[currentLang];
  try {
    const persianText = document.getElementById('persian-input').value.trim();
    const password = document.getElementById('decrypt-password-input').value;

    if (!persianText) {
      showNotification(t.notifyEnterPersian, true);
      return;
    }

    const combined = persianToBytes(persianText);
    const version = combined[0];
    if (version !== 1) {
      throw new Error('Unsupported version');
    }

    const salt = combined.slice(1, 17);
    const iv = combined.slice(17, 29);
    const ciphertext = combined.slice(29);

    const key = await deriveKey(password, salt);
    const decrypted = await crypto.subtle.decrypt(
      { name: 'AES-GCM', iv: iv },
      key,
      ciphertext
    );

    const decoder = new TextDecoder();
    const url = decoder.decode(decrypted);

    document.getElementById('decrypted-output').value = url;
    showNotification(t.notifyDecryptSuccess);
  } catch (error) {
    console.error('Decryption error:', error);
    showNotification(t.notifyDecryptFailed, true);
  }
}
