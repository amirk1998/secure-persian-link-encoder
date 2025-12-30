#!/bin/bash
# ========================================
# Secure Persian Link Encoder
# Linux Build Script
# ========================================

echo ""
echo "╔════════════════════════════════════════╗"
echo "║  Secure Persian Link Encoder Builder  ║"
echo "║         Linux Version                 ║"
echo "╚════════════════════════════════════════╝"
echo ""

# Check Python
echo "[1/7] Checking Python..."
if ! command -v python3 &> /dev/null; then
    echo "❌ ERROR: Python 3 not found!"
    echo "Install with: sudo apt install python3 python3-pip"
    exit 1
fi
python3 --version
echo "✅ OK!"

# Upgrade pip
echo ""
echo "[2/7] Upgrading pip..."
python3 -m pip install --upgrade pip --quiet
echo "✅ OK!"

# Install dependencies
echo ""
echo "[3/7] Installing dependencies..."
pip3 install --upgrade customtkinter cryptography pyperclip Pillow pyinstaller --quiet
if [ $? -ne 0 ]; then
    echo "❌ Failed to install dependencies!"
    exit 1
fi
echo "✅ OK!"

# Test crypto
echo ""
echo "[4/7] Running tests..."
python3 crypto_core.py
if [ $? -ne 0 ]; then
    echo "❌ Tests failed!"
    exit 1
fi
echo "✅ Tests passed!"

# Clean
echo ""
echo "[5/7] Cleaning old builds..."
rm -rf build dist *.spec
echo "✅ Cleaned!"

# Build
echo ""
echo "[6/7] Building executable..."
echo "⏳ This will take 2-3 minutes..."
echo ""

pyinstaller --name="SecurePersianLink" \
            --onefile \
            --windowed \
            --add-data="crypto_core.py:." \
            --hidden-import=customtkinter \
            --hidden-import=PIL \
            --hidden-import=PIL._tkinter_finder \
            --hidden-import=pyperclip \
            --hidden-import=cryptography \
            --hidden-import=cryptography.hazmat.primitives.kdf.pbkdf2 \
            --hidden-import=cryptography.hazmat.primitives.ciphers.aead \
            --hidden-import=cryptography.hazmat.primitives.hashes \
            --hidden-import=cryptography.hazmat.backends \
            --hidden-import=cryptography.hazmat.backends.openssl \
            main.py

if [ $? -ne 0 ]; then
    echo ""
    echo "❌ BUILD FAILED!"
    exit 1
fi

# Make executable
chmod +x "dist/SecurePersianLink"
echo "✅ Build successful!"

# Cleanup
echo ""
echo "[7/7] Cleaning up..."
rm -rf build *.spec
echo "✅ Done!"

# Show results
echo ""
echo "╔════════════════════════════════════════╗"
echo "║         BUILD SUCCESSFUL! 🎉          ║"
echo "╚════════════════════════════════════════╝"
echo ""
echo "📁 Location: dist/SecurePersianLink"
echo ""
ls -lh dist/SecurePersianLink
echo ""
echo "🚀 Run with:"
echo "   ./dist/SecurePersianLink"
echo ""
echo "   Or double-click in file manager"
echo ""