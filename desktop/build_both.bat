@echo off
REM ========================================
REM Build BOTH Single EXE + Portable
REM ========================================

echo.
echo ╔════════════════════════════════════════╗
echo ║     Building BOTH Versions             ║
echo ║  1. Single EXE (25 MB)                ║
echo ║  2. Portable Folder (20 MB)           ║
echo ╚════════════════════════════════════════╝
echo.

REM Check icon
if not exist icon.ico (
    echo ⚠️  icon.ico not found - building without icon
    set ICON_PARAM=
) else (
    echo ✅ icon.ico found!
    set ICON_PARAM=--icon=icon.ico
)

REM Clean
echo.
echo [1/3] Cleaning old builds...
if exist build rmdir /s /q build
if exist dist rmdir /s /q dist
if exist "*.spec" del /q "*.spec"
echo ✅ Done!

REM Build Single EXE
echo.
echo [2/3] Building Single EXE...
echo ⏳ Please wait...
pyinstaller --name="SecurePersianLink-SingleFile" ^
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
            main.py

if errorlevel 1 (
    echo ❌ Single EXE build failed!
    pause
    exit /b 1
)
echo ✅ Single EXE Done!

REM Clean for next build
if exist build rmdir /s /q build

REM Build Portable
echo.
echo [3/3] Building Portable Folder...
echo ⏳ Please wait...
pyinstaller --name="SecurePersianLink-Portable" ^
            --onedir ^
            --windowed ^
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
            main.py

if errorlevel 1 (
    echo ❌ Portable build failed!
    pause
    exit /b 1
)
echo ✅ Portable Done!

REM Cleanup
if exist build rmdir /s /q build
if exist "*.spec" del /q "*.spec"

echo.
echo ╔════════════════════════════════════════╗
echo ║        BUILD COMPLETED! 🎉            ║
echo ╚════════════════════════════════════════╝
echo.
echo 📦 Single EXE:
echo    dist\SecurePersianLink-SingleFile.exe
echo.
echo 📁 Portable Folder:
echo    dist\SecurePersianLink-Portable\
echo.
echo ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
echo 💡 Single EXE = Easy to share (one file)
echo 💡 Portable  = Faster startup (folder)
echo ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
echo.
pause