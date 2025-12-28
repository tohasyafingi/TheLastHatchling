# GitHub Upload Checklist ✅

Project "The Last Hatchling" telah dipersiapkan untuk upload ke GitHub dengan struktur profesional.

## Files yang Sudah Disiapkan

### 📋 Documentation Files
- ✅ **README.md** - Overview project, features, dan cara setup
- ✅ **CONTRIBUTING.md** - Panduan untuk kontributor
- ✅ **DEVELOPMENT.md** - Tips development dan architecture
- ✅ **CHANGELOG.md** - Riwayat versi dan perubahan
- ✅ **LICENSE** - MIT License untuk project

### 🔧 Git Configuration Files
- ✅ **.gitignore** - Ignore Godot-specific, OS, dan IDE files
  - `.godot/` directory (cache)
  - Export folders
  - IDE settings (.vscode, .idea)
  - OS files (Thumbs.db, .DS_Store)
  - Python cache, compiled files

- ✅ **.gitattributes** - Line ending normalization
  - LF untuk semua text files
  - Binary handling untuk assets

### 🐙 GitHub Configuration
- ✅ **.github/pull_request_template.md** - PR template untuk contributors
- ✅ **.github/ISSUE_TEMPLATE/bug_report.md** - Bug report template
- ✅ **.github/ISSUE_TEMPLATE/feature_request.md** - Feature request template

## Langkah Upload ke GitHub

### 1. Buat Repository di GitHub
```bash
# Go to https://github.com/new
# Repository name: dragon (atau nama lain)
# Description: "The Last Hatchling - A 2D Platformer Adventure Game"
# Public atau Private (sesuai preferensi)
# TIDAK perlu menambah .gitignore (sudah ada)
# TIDAK perlu menambah README (sudah ada)
```

### 2. Push Project ke GitHub
```bash
# Navigate ke project folder
cd "e:\KULIAH\KULIAH SMT 7\Pengembangan Game\Dragon\dragon"

# Initialize git (jika belum ada)
git init

# Add all files
git add .

# First commit
git commit -m "Initial commit: The Last Hatchling game"

# Add remote repository
git remote add origin https://github.com/yourusername/dragon.git

# Push ke GitHub
git branch -M main
git push -u origin main
```

### 3. Verifikasi di GitHub
- [ ] Visit https://github.com/yourusername/dragon
- [ ] Verify all files visible
- [ ] Check README displays correctly
- [ ] Check folder structure intact
- [ ] Check .gitignore is working

## .gitignore yang Diabaikan ✅

Ketika push ke GitHub, file-file ini TIDAK akan diupload (sudah dikonfigurasi):

### Godot-Specific
- `.godot/` - Cache directory (auto-generated)
- `*.translation` - Translation files
- `*.pot` - Translation templates
- `export/` - Export builds
- `user_settings/` - User preferences

### OS Files
- `.DS_Store` - macOS metadata
- `Thumbs.db` - Windows thumbnail cache
- `Desktop.ini` - Windows config

### IDE/Editor
- `.vscode/` - VS Code settings
- `.idea/` - IntelliJ settings
- `*.sublime-workspace` - Sublime Text
- `*.swp`, `*.swo` - Vim swap files

### Compiled/Build
- `*.exe`, `*.dll`, `*.so` - Compiled files
- `*.pck`, `*.zip` - Packaged builds
- `__pycache__/`, `*.pyc` - Python cache

### Other
- `.env`, `.env.local` - Environment variables
- `*.log` - Log files
- `*.tmp`, `*.bak` - Temporary files

## Yang AKAN Diupload ✅

### Source Code & Scenes
- `scenes/` - Semua .tscn files
- `scripts/` - Semua .gd files
- `project.godot` - Project configuration
- `icon.svg` - Project icon

### Assets
- `assets/images/` - Sprites, tilesets (PNG)
- `assets/sfx/` - Audio files (MP3, WAV)

### Documentation
- `README.md`
- `CONTRIBUTING.md`
- `DEVELOPMENT.md`
- `CHANGELOG.md`
- `LICENSE`

### GitHub Templates
- `.github/pull_request_template.md`
- `.github/ISSUE_TEMPLATE/bug_report.md`
- `.github/ISSUE_TEMPLATE/feature_request.md`

### Config Files
- `.gitignore`
- `.gitattributes`
- `.editorconfig` (jika ada)

## Tips GitHub

### Membuat README Menarik
- [✓] Screenshot/GIF gameplay
- [✓] Feature list dengan emoji
- [✓] Setup instructions
- [✓] Controls/gameplay
- [✓] Credits & license

### Membuat Project Professional
- [✓] Jelas README
- [✓] Contributing guidelines
- [✓] Issue templates
- [✓] PR template
- [✓] Proper .gitignore
- [✓] LICENSE file

### Collaboration
- Gunakan Issues untuk bugs/features
- Gunakan Pull Requests untuk changes
- Review code sebelum merge
- Keep changelog updated

## Next Steps (Setelah Upload)

1. **Setup GitHub Pages (Optional)**
   - Bisa showcase game di browser
   - Edit Settings > Pages

2. **Add Topics/Tags**
   - `godot`
   - `game-development`
   - `platformer`
   - `2d-game`

3. **Enable Discussions (Optional)**
   - Untuk community discussion
   - Settings > Discussions

4. **Setup Releases**
   - Create releases untuk exported builds
   - Add changelog untuk setiap release

5. **Configure Branch Protection (Optional)**
   - Require PR reviews sebelum merge
   - Require status checks to pass

## Troubleshooting

### File terlalu besar
```bash
# Install Git LFS untuk file besar
git lfs install
git lfs track "*.wav" "*.mp3" "*.png"
git add .gitattributes
git commit -m "Setup Git LFS"
```

### Sync dengan remote
```bash
git fetch origin
git merge origin/main
# atau
git pull origin main
```

### Undo last commit
```bash
git reset --soft HEAD~1
git reset --hard HEAD~1  # Hati-hati!
```

---

## Ringkasan Final ✅

Project "The Last Hatchling" sudah siap untuk professional GitHub upload dengan:
- ✅ Comprehensive .gitignore
- ✅ Clear README & documentation
- ✅ Contributor guidelines
- ✅ GitHub issue & PR templates
- ✅ Proper licensing
- ✅ Development guide

**Status**: READY FOR GITHUB UPLOAD 🚀

---

**Created**: December 29, 2025
**Last Updated**: December 29, 2025
