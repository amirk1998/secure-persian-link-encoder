@echo off
REM ========================================
REM Secure Persian Link Encoder - Build Script
REM Windows 11 - Fixed version
REM ========================================

echo.
echo ========================================
echo Secure Persian Link Encoder
echo Build Script for Windows 11
echo ========================================
echo.

REM Step 1: Check Python
echo [1/7] Checking Python installation...
python --version >nul 2>&1
if errorlevel 1 (
    echo.
    echo ERROR: Python is not installed!
    echo Please install Python 3.8+ from python.org
    echo.
    pause
    exit /b 1
)
python --version
echo OK!

REM Step 2: Upgrade pip
echo.
echo [2/7] Upgrading pip...
python -m pip install --upgrade pip --quiet
echo OK!

REM Step 3: Install dependencies
echo.
echo [3/7] Installing/Updating dependencies...
pip install --upgrade customtkinter cryptography pyperclip Pillow pyinstaller --quiet
if errorlevel 1 (
    echo ERROR: Failed to install dependencies!
    pause
    exit /b 1
)
echo OK!

REM Step 4: Test crypto_core
echo.
echo [4/7] Running crypto tests...
python crypto_core.py
if errorlevel 1 (
    echo.
    echo ERROR: Crypto tests failed!
    echo Please check crypto_core.py file
    echo.
    pause
    exit /b 1
)
echo OK!

REM Step 5: Clean old builds
echo.
echo [5/7] Cleaning old builds...
if exist build (
    rmdir /s /q build
    echo Removed build folder
)
if exist dist (
    rmdir /s /q dist
    echo Removed dist folder
)
if exist "*.spec" (
    del /q "*.spec"
    echo Removed spec files
)
echo OK!

REM Step 6: Build executable
echo.
echo [6/7] Building EXE with PyInstaller...
echo This may take 2-3 minutes...
echo.

pyinstaller --name="SecurePersianLink" ^
            --onefile ^
            --windowed ^
            --noconsole ^
            --add-data="crypto_core.py;." ^
            --hidden-import=customtkinter ^
            --hidden-import=PIL ^
            --hidden-import=PIL._tkinter_finder ^
            --hidden-import=pyperclip ^
            --hidden-import=cryptography ^
            --hidden-import=cryptography.hazmat.primitives.kdf.pbkdf2 ^
            --hidden-import=cryptography.hazmat.primitives.ciphers.aead ^
            --hidden-import=cryptography.hazmat.primitives.hashes ^
            --hidden-import=cryptography.hazmat.backends ^
            --hidden-import=cryptography.hazmat.backends.openssl ^
            --hidden-import=cryptography.fernet ^
            main.py

if errorlevel 1 (
    echo.
    echo ========================================
    echo ERROR: Build FAILED!
    echo ========================================
    echo.
    echo Please check the error messages above
    echo.
    pause
    exit /b 1
)

echo OK!

REM Step 7: Cleanup
echo.
echo [7/7] Cleaning up...
if exist build (
    rmdir /s /q build
    echo Removed build folder
)
if exist "*.spec" (
    del /q "*.spec"
    echo Removed spec files
)
echo OK!

REM Success message
echo.
echo ========================================
echo BUILD SUCCESSFUL!
echo ========================================
echo.
echo Your executable is ready:
echo Location: dist\SecurePersianLink.exe
echo.
echo File size: 
dir dist\SecurePersianLink.exe | find ".exe"
echo.
echo ========================================
echo Next Steps:
echo ========================================
echo 1. Go to: dist folder
echo 2. Double-click: SecurePersianLink.exe
echo 3. Test encryption/decryption
echo.
echo You can copy this .exe file anywhere!
echo No Python installation needed!
echo.
pause