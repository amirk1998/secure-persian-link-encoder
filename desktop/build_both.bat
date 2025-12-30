@echo off
echo ========================================
echo Building BOTH versions
echo ========================================
echo.

REM Clean previous builds
if exist build rmdir /s /q build
if exist dist rmdir /s /q dist

echo [1/2] Building Single EXE...
pyinstaller --name="SecurePersianLink-SingleFile" ^
            --onefile ^
            --windowed ^
            --icon=icon.ico ^
            --add-data="crypto_core.py;." ^
            --hidden-import=customtkinter ^
            --hidden-import=cryptography ^
            --hidden-import=pyperclip ^
            --noconsole ^
            main.py

echo.
echo [2/2] Building Portable Folder...
pyinstaller --name="SecurePersianLink-Portable" ^
            --onedir ^
            --windowed ^
            --icon=icon.ico ^
            --add-data="crypto_core.py;." ^
            --hidden-import=customtkinter ^
            --hidden-import=cryptography ^
            --hidden-import=pyperclip ^
            main.py

echo.
echo ========================================
echo Build completed!
echo ========================================
echo.
echo Single EXE: dist\SecurePersianLink-SingleFile.exe
echo Portable:   dist\SecurePersianLink-Portable\
echo.
pause