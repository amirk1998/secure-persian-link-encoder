#!/bin/bash
# Secure Persian Link Encoder - Linux Build Script
# This script creates a standalone Linux executable

echo "========================================"
echo "Building Secure Persian Link Encoder"
echo "========================================"
echo

# Check if Python is installed
if ! command -v python3 &> /dev/null; then
    echo "ERROR: Python 3 is not installed!"
    echo "Please install Python 3.8 or higher"
    exit 1
fi

echo "[1/5] Installing dependencies..."
pip3 install -r requirements.txt
if [ $? -ne 0 ]; then
    echo "ERROR: Failed to install dependencies!"
    exit 1
fi

echo
echo "[2/5] Cleaning previous builds..."
rm -rf build dist "Secure Persian Link Encoder.spec"

echo
echo "[3/5] Running tests..."
python3 crypto_core.py
if [ $? -ne 0 ]; then
    echo "ERROR: Tests failed!"
    exit 1
fi

echo
echo "[4/5] Building executable with PyInstaller..."
pyinstaller --name="Secure Persian Link Encoder" \
            --onefile \
            --windowed \
            --add-data="crypto_core.py:." \
            --hidden-import=customtkinter \
            --hidden-import=cryptography \
            --hidden-import=pyperclip \
            main.py

if [ $? -ne 0 ]; then
    echo "ERROR: Build failed!"
    exit 1
fi

echo
echo "[5/5] Cleaning up..."
rm -rf build "Secure Persian Link Encoder.spec"

# Make executable runnable
chmod +x "dist/Secure Persian Link Encoder"

echo
echo "========================================"
echo "Build completed successfully!"
echo "========================================"
echo
echo "Executable location: dist/Secure Persian Link Encoder"
echo
echo "You can now run the application with:"
echo "./dist/Secure\ Persian\ Link\ Encoder"
echo