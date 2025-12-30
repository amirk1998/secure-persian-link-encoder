# 🚀 راهنمای Build - Secure Persian Link Encoder

## 📋 فهرست محتوا

- [ویندوز](#windows-build)
  - [Single EXE](#1-single-exe-build)
  - [Both Versions](#2-both-versions-build)
  - [Complete Release](#3-complete-release-build)
- [لینوکس](#linux-build)
- [نکات مهم](#important-notes)

---

## 🪟 Windows Build

### پیش‌نیازها:

```bash
# نصب پایتون از python.org
python --version  # باید 3.8+ باشه

# نصب کتابخانه‌ها
pip install -r requirements.txt
```

---

### 1️⃣ Single EXE Build

**فایل:** `build.bat`

**خروجی:** یک فایل `.exe` واحد (~25-30 MB)

**نحوه استفاده:**

```batch
# دوبار کلیک روی build.bat
# یا در CMD:
build.bat
```

**نتیجه:**

```
dist\
└── SecurePersianLink.exe    # فایل نهایی
```

**مناسب برای:**

- ✅ دانلود از اینترنت
- ✅ ارسال از طریق ایمیل
- ✅ توزیع ساده
- ❌ استارت کمی کندتر

---

### 2️⃣ Both Versions Build

**فایل:** `build_both.bat`

**خروجی:** هر دو نوع Single + Portable

**نحوه استفاده:**

```batch
build_both.bat
```

**نتیجه:**

```
dist\
├── SecurePersianLink-SingleFile.exe     # Single EXE
└── SecurePersianLink-Portable\          # Portable Folder
    ├── SecurePersianLink-Portable.exe
    └── _internal\
```

**مقایسه:**

| ویژگی      | Single EXE | Portable               |
| ---------- | ---------- | ---------------------- |
| تعداد فایل | 1 فایل     | چند فایل در پوشه       |
| حجم        | ~25-30 MB  | ~20-25 MB              |
| سرعت اجرا  | کندتر      | سریع‌تر                |
| انتقال     | آسان       | باید کل پوشه منتقل شود |

---

### 3️⃣ Complete Release Build

**فایل:** `build_complete.bat`

**خروجی:** پوشه Release سازماندهی شده

**نحوه استفاده:**

```batch
build_complete.bat
```

**نتیجه:**

```
dist\
└── Release\
    ├── SingleFile\
    │   └── SecurePersianLink.exe
    ├── Portable\
    │   └── SecurePersianLink-Portable\
    ├── README.md
    └── README_FA.md
```

**مناسب برای:**

- ✅ توزیع رسمی
- ✅ آپلود به GitHub Releases
- ✅ ارائه به کاربران نهایی

---

## 🐧 Linux Build

### پیش‌نیازها:

```bash
# Ubuntu/Debian
sudo apt update
sudo apt install python3 python3-pip

# نصب کتابخانه‌ها
pip3 install -r requirements.txt
```

### Build:

```bash
# اجازه اجرا به اسکریپت
chmod +x build.sh

# اجرای build
./build.sh
```

### نتیجه:

```
dist/
└── SecurePersianLink    # فایل اجرایی لینوکس
```

### اجرا:

```bash
# روش 1: از ترمینال
./dist/SecurePersianLink

# روش 2: دوبار کلیک در فایل منیجر
```

---

## 📦 ساختار پروژه

```
SecurePersianLink/
│
├── main.py                 # UI اصلی
├── crypto_core.py          # موتور رمزنگاری
├── requirements.txt        # کتابخانه‌ها
├── icon.ico               # آیکون (اختیاری)
│
├── build.bat              # Build ساده (Windows)
├── build_both.bat         # Build هر دو نوع (Windows)
├── build_complete.bat     # Build کامل (Windows)
├── build.sh               # Build (Linux)
│
├── README.md              # راهنمای انگلیسی
└── README_FA.md           # راهنمای فارسی
```

---

## ⚙️ تنظیمات Build

### با آیکون سفارشی:

اگر فایل `icon.ico` در پوشه پروژه باشه، خودکار اضافه میشه.

### بدون آیکون:

اگر `icon.ico` نباشه، برنامه با آیکون پیش‌فرض ساخته میشه.

---

## 🎯 گام به گام برای مبتدی‌ها

### ویندوز:

```batch
# 1. باز کردن CMD در پوشه پروژه
cd C:\path\to\project

# 2. نصب کتابخانه‌ها (فقط یک بار)
pip install -r requirements.txt

# 3. Build کردن
build.bat

# 4. تست
dist\SecurePersianLink.exe
```

### لینوکس:

```bash
# 1. باز کردن Terminal در پوشه پروژه
cd /path/to/project

# 2. نصب کتابخانه‌ها (فقط یک بار)
pip3 install -r requirements.txt

# 3. اجازه اجرا
chmod +x build.sh

# 4. Build کردن
./build.sh

# 5. تست
./dist/SecurePersianLink
```

---

## ⚠️ نکات مهم

### 1. Antivirus Warning

بعضی آنتی‌ویروس‌ها ممکنه فایل EXE رو مشکوک بدونن.

**راه‌حل:**

- اضافه کردن به لیست استثنائات
- برای توزیع رسمی: دیجیتال امضا کردن

### 2. حجم فایل

```
Single EXE: 25-30 MB
Portable:   20-25 MB (کل پوشه)
Linux:      30-35 MB
```

این حجم طبیعیه چون همه کتابخانه‌ها داخل فایل بسته‌بندی شدن.

### 3. Python نیست!

فایل‌های build شده نیازی به نصب پایتون ندارن و روی هر سیستمی کار می‌کنن.

### 4. به‌روزرسانی

برای به‌روزرسانی برنامه:

1. کد رو تغییر بدید
2. دوباره build کنید
3. فایل قدیمی رو با جدید جایگزین کنید

---

## 🔍 عیب‌یابی

### مشکل: "Python not found"

```bash
# نصب پایتون از python.org
# حتماً "Add to PATH" رو تیک بزنید
```

### مشکل: "pip not found"

```bash
python -m pip install --upgrade pip
```

### مشکل: "Import Error"

```bash
# حذف و نصب دوباره کتابخانه‌ها
pip uninstall customtkinter cryptography pyperclip -y
pip install -r requirements.txt
```

### مشکل: "Build failed"

```bash
# پاک کردن build های قبلی
rmdir /s /q build dist    # Windows
rm -rf build dist         # Linux

# Build دوباره
build.bat                 # Windows
./build.sh                # Linux
```

---

## 📤 توزیع

### GitHub Releases:

```bash
# 1. Build کامل
build_complete.bat

# 2. فشرده‌سازی
# - Zip کردن dist\Release\SingleFile
# - Zip کردن dist\Release\Portable

# 3. آپلود به GitHub Releases
```

### دانلود مستقیم:

```
مناسب:        Single EXE
حجم:          25-30 MB
آسان:         ✅
```

### USB / فلش:

```
مناسب:        Portable Folder
سرعت:         سریع‌تر
کپی:          کل پوشه
```

---

## 🎉 موفق باشید!

اگر مشکلی داشتید، issue بسازید یا بپرسید.

**نکته:** همیشه قبل از توزیع، فایل‌ها رو تست کنید! ✅
