@echo off
REM ========================================
REM Complete Builder with Organization
REM Creates organized Release folder
REM ========================================

echo.
echo ╔════════════════════════════════════════╗
echo ║   Secure Persian Link Encoder         ║
echo ║   COMPLETE BUILD + RELEASE            ║
echo ╚════════════════════════════════════════╝
echo.

REM Check Python
echo [Step 1/9] Checking Python...
python --version >nul 2>&1
if errorlevel 1 (
    echo ❌ ERROR: Python not found!
    pause
    exit /b 1
)
python --version
echo ✅ OK!

REM Check icon
echo.
echo [Step 2/9] Checking icon...
if not exist icon.ico (
    echo ⚠️  icon.ico not found
    set ICON_PARAM=
) else (
    echo ✅ icon.ico found!
    set ICON_PARAM=--icon=icon.ico
)

REM Install/Update
echo.
echo [Step 3/9] Updating dependencies...
pip install --upgrade customtkinter cryptography pyperclip Pillow pyinstaller --quiet
echo ✅ OK!

REM Test
echo.
echo [Step 4/9] Running tests...
python crypto_core.py
if errorlevel 1 (
    echo ❌ Tests failed!
    pause
    exit /b 1
)
echo ✅ Tests passed!

REM Clean
echo.
echo [Step 5/9] Cleaning old builds...
if exist build rmdir /s /q build
if exist dist rmdir /s /q dist
if exist "*.spec" del /q "*.spec"
echo ✅ Cleaned!

REM Build Single EXE
echo.
echo [Step 6/9] Building Single EXE...
echo ⏳ This will take 2-3 minutes...
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
            main.py

if errorlevel 1 (
    echo ❌ Single EXE failed!
    pause
    exit /b 1
)

REM Move single file
move dist\SecurePersianLink.exe dist\SecurePersianLink-SingleFile.exe >nul
echo ✅ Single EXE built!

REM Clean for portable
if exist build rmdir /s /q build

REM Build Portable
echo.
echo [Step 7/9] Building Portable version...
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
echo ✅ Portable built!

REM Organize
echo.
echo [Step 8/9] Organizing Release folder...
mkdir dist\Release 2>nul
mkdir dist\Release\SingleFile 2>nul
mkdir dist\Release\Portable 2>nul

move dist\SecurePersianLink-SingleFile.exe dist\Release\SingleFile\ >nul
move dist\SecurePersianLink-Portable dist\Release\Portable\ >nul

REM Copy documentation
if exist README.md copy README.md dist\Release\ >nul
if exist README_FA.md copy README_FA.md dist\Release\ >nul

echo ✅ Organized!

REM Cleanup
echo.
echo [Step 9/9] Final cleanup...
if exist build rmdir /s /q build
if exist "*.spec" del /q "*.spec"
echo ✅ Done!

REM Show results
echo.
echo ╔════════════════════════════════════════╗
echo ║      BUILD COMPLETED! 🎉              ║
echo ╚════════════════════════════════════════╝
echo.
echo 📦 Release folder: dist\Release\
echo.
echo ├─ 📂 SingleFile\
echo │  └─ SecurePersianLink.exe
echo │     └─ Size: ~25-30 MB
echo │     └─ Use: Easy to share
echo │
echo └─ 📂 Portable\
echo    └─ SecurePersianLink-Portable\
echo       └─ Size: ~20-25 MB total
echo       └─ Use: Faster startup
echo.
echo ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
echo 🎯 NEXT STEPS:
echo ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
echo.
echo 1. Test both versions
echo 2. Check encryption/decryption works
echo 3. Ready for distribution!
echo.
echo For GitHub Release:
echo   - Zip SingleFile folder
echo   - Zip Portable folder
echo   - Upload both as release assets
echo.
pause