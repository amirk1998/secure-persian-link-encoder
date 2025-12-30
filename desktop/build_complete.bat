@echo off
echo ================================================
echo Secure Persian Link Encoder - Complete Builder
echo ================================================
echo.

REM Step 1: Check Python
python --version >nul 2>&1
if errorlevel 1 (
    echo ERROR: Python not found!
    pause
    exit /b 1
)

REM Step 2: Install dependencies
echo [1/5] Installing dependencies...
pip install -r requirements.txt
pip install pyinstaller --upgrade

REM Step 3: Clean
echo [2/5] Cleaning old builds...
if exist build rmdir /s /q build
if exist dist rmdir /s /q dist

REM Step 4: Build Single EXE
echo [3/5] Building Single EXE...
pyinstaller --name="SecurePersianLink" ^
            --onefile ^
            --windowed ^
            --noconsole ^
            --icon=icon.ico ^
            --add-data="crypto_core.py;." ^
            --hidden-import=customtkinter ^
            --hidden-import=cryptography ^
            --hidden-import=pyperclip ^
            main.py

REM Move single file
move dist\SecurePersianLink.exe dist\SecurePersianLink-SingleFile.exe

REM Step 5: Build Portable
echo [4/5] Building Portable version...
if exist build rmdir /s /q build
pyinstaller --name="SecurePersianLink-Portable" ^
            --onedir ^
            --windowed ^
            --icon=icon.ico ^
            --add-data="crypto_core.py;." ^
            --hidden-import=customtkinter ^
            --hidden-import=cryptography ^
            --hidden-import=pyperclip ^
            main.py

REM Step 6: Organize
echo [5/5] Organizing files...
mkdir dist\Release
mkdir dist\Release\SingleFile
mkdir dist\Release\Portable

move dist\SecurePersianLink-SingleFile.exe dist\Release\SingleFile\
move dist\SecurePersianLink-Portable dist\Release\Portable\

REM Copy documentation
copy README.md dist\Release\
copy README_FA.md dist\Release\

REM Cleanup
rmdir /s /q build

echo.
echo ================================================
echo Build COMPLETE!
echo ================================================
echo.
echo Location: dist\Release\
echo   - SingleFile: Single EXE (~25 MB)
echo   - Portable:   Folder with files
echo.
echo Test both versions before distribution!
echo.
pause