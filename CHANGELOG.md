# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- Initial setup of GitHub Actions workflow
- Automated builds for Windows (EXE and Portable)
- Automated builds for Linux (DEB and RPM)
- Semantic versioning support

## [1.0.0] - 2025-12-30

### Added

- 🔒 AES-256-GCM encryption for URLs
- 🌐 Bilingual interface (Persian/Farsi and English)
- 🌙 Dark mode and Light mode support
- 🎨 Modern glassmorphism UI design
- 📱 PWA support for web version
- 💻 Desktop application with CustomTkinter
- 📦 Cross-platform support (Windows, Linux)
- 🔐 Optional password protection
- 📋 Copy to clipboard functionality
- 🌐 Direct URL opening from decrypted text
- ✅ PBKDF2 key derivation with 100,000 iterations
- 🔄 Persian character encoding (Base-50)
- 📄 Comprehensive documentation
- 🛡️ Security analysis document
- 🚀 Quick start guide

### Security

- Implemented AES-256-GCM authenticated encryption
- Added salt and IV randomization
- PBKDF2 with SHA-256 for key derivation
- All operations performed locally (fully offline)

### Documentation

- Added README.md with installation instructions
- Added SECURITY_ANALYSIS.md with detailed security information
- Added BUILD_GUIDE.md for building from source
- Added PORTABLE_BUILD_GUIDE.md for portable builds
- Added QUICKSTART.md for quick setup

---

## Version History

- **1.0.0**: Initial release
  - First stable version with all core features
  - Desktop application for Windows and Linux
  - PWA web application
  - Comprehensive documentation

---

## Types of Changes

- `Added` for new features
- `Changed` for changes in existing functionality
- `Deprecated` for soon-to-be removed features
- `Removed` for now removed features
- `Fixed` for any bug fixes
- `Security` for vulnerability fixes

---

## Release Notes Template

```markdown
## [X.Y.Z] - YYYY-MM-DD

### Added

- New feature description

### Changed

- Changed feature description

### Fixed

- Bug fix description

### Security

- Security improvement description
```

---

## Links

- [GitHub Repository](https://github.com/yourusername/secure-persian-link)
- [Issue Tracker](https://github.com/yourusername/secure-persian-link/issues)
- [Releases](https://github.com/yourusername/secure-persian-link/releases)
