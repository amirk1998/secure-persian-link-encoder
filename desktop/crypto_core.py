"""
Secure Persian Link Encoder - Crypto Core
AES-256-GCM encryption with Persian encoding
Author: Amir Hossein Kaveh
License: MIT
"""

import os
import hashlib
from cryptography.hazmat.primitives.ciphers.aead import AESGCM
from cryptography.hazmat.primitives import hashes
from cryptography.hazmat.primitives.kdf.pbkdf2 import PBKDF2HMAC
from cryptography.hazmat.backends import default_backend


class CryptoCore:
    """
    Core encryption/decryption engine using AES-256-GCM
    """

    # Persian alphabet (50 characters for Base-50 encoding)
    PERSIAN_ALPHABET = "ابپتثجچحخدذرزژسشصضطظعغفقکگلمنوهیآأإؤئة۰۱۲۳۴۵۶۷۸۹"

    # Master seed for default encryption (when no password provided)
    MASTER_SEED = b"SecurePersianLinkEncoder2025DefaultKey!"

    # Encryption parameters
    VERSION = 1
    SALT_SIZE = 16
    IV_SIZE = 12
    KEY_SIZE = 32
    ITERATIONS = 100000

    def __init__(self):
        """Initialize crypto core"""
        self.backend = default_backend()

    def derive_key(self, password: str, salt: bytes) -> bytes:
        """
        Derive encryption key from password using PBKDF2

        Args:
            password: User password (or None for default)
            salt: Random salt bytes

        Returns:
            32-byte encryption key
        """
        if password is None or password == "":
            # Use master seed for default encryption
            key = hashlib.sha256(self.MASTER_SEED).digest()
            return key

        # Derive key from password using PBKDF2
        kdf = PBKDF2HMAC(
            algorithm=hashes.SHA256(),
            length=self.KEY_SIZE,
            salt=salt,
            iterations=self.ITERATIONS,
            backend=self.backend,
        )
        key = kdf.derive(password.encode("utf-8"))
        return key

    def encrypt(self, url: str, password: str = None) -> str:
        """
        Encrypt URL to Persian text

        Args:
            url: URL to encrypt
            password: Optional password for encryption

        Returns:
            Persian encoded encrypted text
        """
        # Generate random salt and IV
        salt = os.urandom(self.SALT_SIZE)
        iv = os.urandom(self.IV_SIZE)

        # Derive encryption key
        key = self.derive_key(password, salt)

        # Create AESGCM cipher
        aesgcm = AESGCM(key)

        # Encrypt URL (includes authentication tag)
        ciphertext = aesgcm.encrypt(iv, url.encode("utf-8"), None)

        # Format: [version:1byte][salt:16bytes][iv:12bytes][ciphertext+tag]
        version_byte = bytes([self.VERSION])
        combined = version_byte + salt + iv + ciphertext

        # Convert to Persian text
        persian_text = self._bytes_to_persian(combined)

        return persian_text

    def decrypt(self, persian_text: str, password: str = None) -> str:
        """
        Decrypt Persian text to URL

        Args:
            persian_text: Persian encoded encrypted text
            password: Optional password for decryption

        Returns:
            Original URL
        """
        # Convert Persian text to bytes
        combined = self._persian_to_bytes(persian_text)

        # Parse components
        version = combined[0]
        if version != self.VERSION:
            raise ValueError(f"Unsupported version: {version}")

        salt = combined[1 : 1 + self.SALT_SIZE]
        iv = combined[1 + self.SALT_SIZE : 1 + self.SALT_SIZE + self.IV_SIZE]
        ciphertext = combined[1 + self.SALT_SIZE + self.IV_SIZE :]

        # Derive decryption key
        key = self.derive_key(password, salt)

        # Create AESGCM cipher
        aesgcm = AESGCM(key)

        # Decrypt (automatically verifies authentication tag)
        try:
            plaintext = aesgcm.decrypt(iv, ciphertext, None)
            url = plaintext.decode("utf-8")
            return url
        except Exception as e:
            raise ValueError(
                "Decryption failed! Wrong password or corrupted data."
            ) from e

    def _bytes_to_persian(self, data: bytes) -> str:
        """
        Convert bytes to Persian text using Base-50 encoding

        Args:
            data: Bytes to convert

        Returns:
            Persian text string
        """
        base = len(self.PERSIAN_ALPHABET)

        # Convert bytes to big integer
        num = int.from_bytes(data, byteorder="big")

        # Handle zero case
        if num == 0:
            return self.PERSIAN_ALPHABET[0]

        # Convert to base-50
        result = []
        while num > 0:
            result.append(self.PERSIAN_ALPHABET[num % base])
            num //= base

        # Reverse to get correct order
        return "".join(reversed(result))

    def _persian_to_bytes(self, persian_text: str) -> bytes:
        """
        Convert Persian text back to bytes using Base-50 decoding

        Args:
            persian_text: Persian text string

        Returns:
            Original bytes
        """
        base = len(self.PERSIAN_ALPHABET)
        num = 0

        # Convert from base-50
        for char in persian_text:
            digit = self.PERSIAN_ALPHABET.find(char)
            if digit == -1:
                raise ValueError(f"Invalid Persian character: {char}")
            num = num * base + digit

        # Convert big integer back to bytes
        # Calculate required byte length
        if num == 0:
            return bytes([0])

        byte_length = (num.bit_length() + 7) // 8
        result = num.to_bytes(byte_length, byteorder="big")

        return result


# Test function
def test_crypto():
    """Test encryption and decryption"""
    crypto = CryptoCore()

    print("=" * 60)
    print("Testing Secure Persian Link Encoder")
    print("=" * 60)

    # Test 1: Without password
    print("\n[Test 1] Without Password:")
    url1 = "https://example.com/test123"
    encrypted1 = crypto.encrypt(url1)
    print(f"Original URL: {url1}")
    print(f"Encrypted: {encrypted1}")
    decrypted1 = crypto.decrypt(encrypted1)
    print(f"Decrypted: {decrypted1}")
    print(
        f"Match: {url1 == decrypted1} ✅" if url1 == decrypted1 else "Match: False ❌"
    )

    # Test 2: With password
    print("\n[Test 2] With Password:")
    url2 = "https://secure.example.com/secret"
    password = "MySecretPassword123"
    encrypted2 = crypto.encrypt(url2, password)
    print(f"Original URL: {url2}")
    print(f"Password: {password}")
    print(f"Encrypted: {encrypted2}")
    decrypted2 = crypto.decrypt(encrypted2, password)
    print(f"Decrypted: {decrypted2}")
    print(
        f"Match: {url2 == decrypted2} ✅" if url2 == decrypted2 else "Match: False ❌"
    )

    # Test 3: Wrong password
    print("\n[Test 3] Wrong Password:")
    try:
        crypto.decrypt(encrypted2, "WrongPassword")
        print("❌ Should have failed!")
    except ValueError as e:
        print(f"✅ Correctly failed: {e}")

    # Test 4: Long URL
    print("\n[Test 4] Long URL:")
    url4 = "https://example.com/very/long/path/with/many/segments?param1=value1&param2=value2&token=abc123xyz"
    encrypted4 = crypto.encrypt(url4)
    print(f"Original URL: {url4}")
    print(f"Encrypted length: {len(encrypted4)} characters")
    decrypted4 = crypto.decrypt(encrypted4)
    print(
        f"Match: {url4 == decrypted4} ✅" if url4 == decrypted4 else "Match: False ❌"
    )

    print("\n" + "=" * 60)
    print("All tests completed!")
    print("=" * 60)


if __name__ == "__main__":
    test_crypto()
