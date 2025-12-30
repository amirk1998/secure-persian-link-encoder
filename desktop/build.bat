@echo off
REM ========================================
REM Secure Persian Link Encoder
REM Single EXE Builder for Windows
REM ========================================

echo.
echo ╔════════════════════════════════════════╗
echo ║  Secure Persian Link Encoder Builder  ║
echo ║        Single EXE Version             ║
echo ╚════════════════════════════════════════╝
echo.

REM Check Python
echo [1/7] Checking Python...
python --version >nul 2>&1
if errorlevel 1 (
    echo ❌ ERROR: Python not found!
    pause
    exit /b 1
)
python --version
echo ✅ OK!

REM Check icon file
echo.
echo [2/7] Checking icon.ico...
if not exist icon.ico (
    echo ⚠️  WARNING: icon.ico not found!
    echo    Building without custom icon...
    set ICON_PARAM=
) else (
    echo ✅ icon.ico found!
    set ICON_PARAM=--icon=icon.ico
)

REM Upgrade pip
echo.
echo [3/7] Upgrading pip...
python -m pip install --upgrade pip --quiet
echo ✅ OK!

REM Install dependencies
echo.
echo [4/7] Installing dependencies...
pip install --upgrade customtkinter cryptography pyperclip Pillow pyinstaller --quiet
echo ✅ OK!

REM Test crypto
echo.
echo [5/7] Running tests...
python crypto_core.py
if errorlevel 1 (
    echo ❌ Tests failed!
    pause
    exit /b 1
)
echo ✅ OK!

REM Clean
echo.
echo [6/7] Cleaning old builds...
if exist build rmdir /s /q build
if exist dist rmdir /s /q dist
if exist "*.spec" del /q "*.spec"
echo ✅ OK!

REM Build
echo.
echo [7/7] Building Single EXE...
echo ⏳ Please wait 2-3 minutes...
echo.

pyinstaller --name="SecurePersianLink" ^
            --onefile ^
            --windowed ^
            --noconsole ^
            %ICON_PARAM% ^
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
    echo ❌ BUILD FAILED!
    pause
    exit /b 1
)

REM Cleanup
if exist build rmdir /s /q build
if exist "*.spec" del /q "*.spec"

echo.
echo ╔════════════════════════════════════════╗
echo ║         BUILD SUCCESSFUL! 🎉          ║
echo ╚════════════════════════════════════════╝
echo.
echo 📁 Location: dist\SecurePersianLink.exe
echo.
dir dist\SecurePersianLink.exe | find ".exe"
echo.
echo 🚀 Ready to use! Double-click to run.
echo.
pause