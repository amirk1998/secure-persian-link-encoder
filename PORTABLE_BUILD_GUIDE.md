# 📦 راهنمای ساخت نسخه Portable و EXE

## 🎯 دو نوع فایل اجرایی

### 1. **Single EXE File** (تک فایل)

- ✅ یک فایل `.exe` واحد
- ✅ همه چیز درون آن بسته‌بندی شده
- ✅ راحت برای انتقال
- ❌ اندازه بزرگ‌تر (~20-30 MB)
- ❌ اجرا کمی کندتر (باید فایل‌ها را extract کند)

### 2. **Portable Folder** (پوشه قابل حمل)

- ✅ یک پوشه با چند فایل
- ✅ اجرای سریع‌تر
- ✅ اندازه کل کوچک‌تر
- ✅ بدون نیاز به نصب
- ❌ باید کل پوشه را منتقل کنید

---

## 🔧 روش 1: ساخت Single EXE File

### ویندوز:

#### مرحله 1: آماده‌سازی محیط

```batch
# اطمینان از نصب پایتون
python --version

# نصب PyInstaller
pip install pyinstaller --upgrade
```

#### مرحله 2: ساخت با PyInstaller

```batch
pyinstaller --name="SecurePersianLink" ^
            --onefile ^
            --windowed ^
            --icon=icon.ico ^
            --add-data="crypto_core.py;." ^
            --hidden-import=customtkinter ^
            --hidden-import=cryptography ^
            --hidden-import=pyperclip ^
            --noconsole ^
            main.py
```

#### توضیح پارامترها:

- `--onefile`: تک فایل EXE (نه پوشه)
- `--windowed`: بدون پنجره کنسول
- `--noconsole`: مخفی کردن cmd
- `--icon=icon.ico`: آیکون سفارشی
- `--name`: نام فایل خروجی

#### مرحله 3: یافتن فایل

```
خروجی: dist\SecurePersianLink.exe
اندازه: ~25-30 MB
```

---

## 🗂️ روش 2: ساخت Portable Folder

### ویندوز:

#### استفاده از PyInstaller (حالت پوشه):

```batch
pyinstaller --name="SecurePersianLink" ^
            --onedir ^
            --windowed ^
            --icon=icon.ico ^
            --add-data="crypto_core.py;." ^
            --hidden-import=customtkinter ^
            --hidden-import=cryptography ^
            --hidden-import=pyperclip ^
            main.py
```

#### خروجی:

```
dist/
└── SecurePersianLink/
    ├── SecurePersianLink.exe    # فایل اصلی
    ├── _internal/                # فایل‌های کتابخانه
    ├── crypto_core.py
    └── سایر فایل‌های dll
```

#### نحوه استفاده:

```
1. کل پوشه SecurePersianLink را کپی کنید
2. به هر جایی که می‌خواهید ببرید (USB, Desktop, ...)
3. فایل SecurePersianLink.exe را اجرا کنید
```

---

## 📝 اسکریپت خودکار برای هر دو نوع

ایجاد فایل `build_both.bat`:

```batch
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
```

---

## 🐧 لینوکس

### Single Binary:

```bash
pyinstaller --name="SecurePersianLink" \
            --onefile \
            --windowed \
            --add-data="crypto_core.py:." \
            --hidden-import=customtkinter \
            --hidden-import=cryptography \
            --hidden-import=pyperclip \
            main.py

chmod +x dist/SecurePersianLink
```

### Portable Folder:

```bash
pyinstaller --name="SecurePersianLink" \
            --onedir \
            --windowed \
            --add-data="crypto_core.py:." \
            --hidden-import=customtkinter \
            --hidden-import=cryptography \
            --hidden-import=pyperclip \
            main.py

chmod +x dist/SecurePersianLink/SecurePersianLink
```

---

## 🎨 اضافه کردن آیکون سفارشی

### ساخت فایل icon.ico:

#### روش 1: آنلاین

```
1. به سایت https://www.icoconverter.com بروید
2. یک تصویر PNG آپلود کنید (256x256 پیشنهادی)
3. دانلود icon.ico
4. در کنار main.py قرار دهید
```

#### روش 2: با Pillow

```python
from PIL import Image

img = Image.open('logo.png')
img.save('icon.ico', format='ICO', sizes=[(256, 256)])
```

---

## 📦 کاهش اندازه فایل

### تکنیک‌های بهینه‌سازی:

#### 1. استفاده از UPX (فشرده‌ساز)

```batch
# دانلود UPX از: https://upx.github.io/
# سپس:
pyinstaller --onefile --upx-dir=C:\path\to\upx main.py
```

**نتیجه**: کاهش 30-50% اندازه

#### 2. حذف فایل‌های غیر ضروری

```batch
pyinstaller --onefile ^
            --exclude-module=matplotlib ^
            --exclude-module=numpy ^
            --exclude-module=pandas ^
            main.py
```

#### 3. استفاده از Virtual Environment

```batch
# ایجاد محیط مجازی تمیز
python -m venv clean_env
clean_env\Scripts\activate

# فقط نصب کتابخانه‌های ضروری
pip install customtkinter cryptography pyperclip

# سپس build
pyinstaller --onefile main.py
```

---

## 🧪 تست فایل‌های ساخته‌شده

### چک‌لیست تست:

#### ✅ تست اولیه

- [ ] اجرای فایل EXE/Binary
- [ ] باز شدن پنجره برنامه
- [ ] عدم ظاهر شدن پنجره کنسول

#### ✅ تست عملکرد

- [ ] رمزنگاری یک لینک تستی
- [ ] کپی متن فارسی
- [ ] رمزگشایی متن فارسی
- [ ] باز شدن لینک در مرورگر

#### ✅ تست Portable

- [ ] کپی به USB
- [ ] اجرا از USB در کامپیوتر دیگر
- [ ] کپی به Desktop
- [ ] اجرا بدون نصب

#### ✅ تست سیستم‌های مختلف

- [ ] ویندوز 10
- [ ] ویندوز 11
- [ ] Ubuntu 20.04+
- [ ] سیستم بدون پایتون

---

## 📂 ساختار نهایی برای توزیع

```
SecurePersianLink-Release/
│
├── Windows/
│   ├── SingleFile/
│   │   └── SecurePersianLink.exe          (~25 MB)
│   │
│   └── Portable/
│       └── SecurePersianLink/
│           ├── SecurePersianLink.exe
│           └── _internal/
│
├── Linux/
│   ├── SingleFile/
│   │   └── SecurePersianLink              (~30 MB)
│   │
│   └── Portable/
│       └── SecurePersianLink/
│           ├── SecurePersianLink
│           └── _internal/
│
├── README.md
├── README_FA.md
└── USAGE_GUIDE.pdf
```

---

## 🚀 اسکریپت نهایی (همه‌چیز در یک فایل)

ذخیره به عنوان `build_complete.bat`:

```batch
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
```

---

## 📤 توزیع

### برای آپلود به GitHub:

```bash
# فشرده‌سازی
zip -r SecurePersianLink-Windows-v1.0.zip dist/Release/SingleFile/
zip -r SecurePersianLink-Windows-Portable-v1.0.zip dist/Release/Portable/

# آپلود به GitHub Releases
gh release create v1.0 \
    SecurePersianLink-Windows-v1.0.zip \
    SecurePersianLink-Windows-Portable-v1.0.zip
```

---

## ⚡ نکات مهم

### ✅ نکته 1: Antivirus

```
برخی آنتی‌ویروس‌ها ممکن است فایل EXE را مشکوک بدانند
راه‌حل:
- اضافه کردن به استثنائات
- دیجیتال امضا کردن فایل (برای توزیع رسمی)
```

### ✅ نکته 2: حجم فایل

```
Single EXE: 25-30 MB (بزرگ اما راحت)
Portable: 20-25 MB کل (سریع‌تر اما چند فایل)
```

### ✅ نکته 3: به‌روزرسانی

```
برای به‌روزرسانی: فقط فایل EXE یا پوشه را جایگزین کنید
تنظیمات کاربر: ذخیره در %APPDATA%/SecurePersianLink/
```

---

## 🎁 فایل نهایی شما

بعد از اجرای `build_complete.bat`:

```
dist/Release/
├── SingleFile/
│   └── SecurePersianLink.exe    ← فایل تک برای توزیع سریع
│
├── Portable/
│   └── SecurePersianLink-Portable/  ← پوشه برای USB
│
├── README.md
└── README_FA.md
```

**حالا می‌توانید:**

- ✅ SingleFile را برای دانلود آنلاین بگذارید
- ✅ Portable را در USB کپی کنید
- ✅ هر دو را در GitHub Releases آپلود کنید

---

🎉 **تمام! شما حالا دو نسخه کامل دارید!**
