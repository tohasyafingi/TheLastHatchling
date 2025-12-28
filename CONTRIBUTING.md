# Contributing to The Last Hatchling

Thank you for your interest in contributing to The Last Hatchling! This document provides guidelines and instructions for contributing.

## Code of Conduct

Please be respectful and constructive in all interactions. Harassment, discrimination, and abusive behavior will not be tolerated.

## How to Contribute

### Reporting Bugs

Before reporting a bug:
1. Check the [existing issues](../../issues) to avoid duplicates
2. Update Godot to the latest version to see if the issue persists
3. Provide a detailed description with steps to reproduce

**To report a bug:**
1. Go to [Issues](../../issues)
2. Click "New Issue"
3. Select "Bug Report" template
4. Fill in all required information

### Suggesting Features

**To suggest a feature:**
1. Go to [Issues](../../issues)
2. Click "New Issue"
3. Select "Feature Request" template
4. Describe your idea clearly

### Code Contributions

#### Setup Development Environment

1. **Fork the repository**
   ```bash
   # Visit https://github.com/yourusername/dragon
   ```

2. **Clone your fork**
   ```bash
   git clone https://github.com/yourusername/dragon.git
   cd dragon
   ```

3. **Create a feature branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

4. **Open in Godot 4**
   - Launch Godot 4
   - Open the `project.godot` file

#### Coding Standards

**GDScript Style Guide:**

```gdscript
# Class structure
class_name MyClass
extends Node

# Constants in UPPER_SNAKE_CASE
const MAX_SPEED = 300.0
const GRAVITY = 800.0

# Variables
var velocity: Vector2 = Vector2.ZERO
var is_jumping: bool = false

# Onready variables at top
@onready var sprite = $Sprite2D
@onready var collision = $CollisionShape2D

# Signals
signal player_jumped
signal health_changed(new_health)

# Private function (leading underscore)
func _ready() -> void:
	pass

# Public function
func jump(force: float) -> void:
	velocity.y = -force
	player_jumped.emit()

# Private helper function
func _calculate_damage(hit_force: float) -> int:
	return int(hit_force * 0.5)
```

**Naming Conventions:**
- `snake_case` for variables and functions
- `PascalCase` for classes
- `UPPER_SNAKE_CASE` for constants
- Prefix private methods with `_`

**Comments:**
- Add comments for complex logic
- Explain the "why" not the "what"
- Use `#` for single-line comments
- Use `"""` for multi-line documentation

#### Making Changes

1. **Create logical, focused commits**
   ```bash
   git add .
   git commit -m "feat: add player double jump mechanic"
   ```

2. **Commit message format:**
   - `feat:` for new features
   - `fix:` for bug fixes
   - `docs:` for documentation
   - `style:` for code style changes
   - `refactor:` for code refactoring
   - `perf:` for performance improvements
   - `test:` for tests

3. **Test thoroughly before submitting**
   - Run the game in debug mode
   - Check for console errors
   - Test on multiple scenes
   - Verify no regressions

#### Submitting a Pull Request

1. **Push to your fork**
   ```bash
   git push origin feature/your-feature-name
   ```

2. **Create a Pull Request**
   - Go to the main repository
   - Click "New Pull Request"
   - Select your branch
   - Fill in the PR template completely

3. **PR Requirements:**
   - Clear, descriptive title
   - Reference related issues
   - Detailed description of changes
   - Screenshots for visual changes
   - No conflicts with main branch
   - Passes all checks

4. **Code Review**
   - Be open to feedback
   - Address comments promptly
   - Push changes to the same branch
   - All conversations should be resolved

### Documentation Contributions

1. **README.md** - Project overview and setup
2. **CONTRIBUTING.md** - This file
3. **Inline code comments** - Explain complex logic
4. **Scene/script documentation** - Add @class_name and docstrings

**To update documentation:**
1. Fork and create a branch
2. Make changes
3. Test that content is clear
4. Submit a PR with the "Documentation update" type

## Project Structure

```
dragon/
├── scenes/              # Godot scene files (.tscn)
│   ├── splash.tscn     # Main scenes
│   ├── home.tscn
│   └── level1.tscn
├── scripts/             # GDScript files (.gd)
│   ├── main.gd
│   ├── player.gd
│   └── [other game scripts]
├── assets/
│   ├── images/          # PNG sprites and tilesets
│   └── sfx/             # MP3/WAV audio files
├── project.godot        # Godot project file
├── README.md            # Project documentation
└── .gitignore          # Git ignore rules
```

## Testing Guidelines

Before submitting:

1. **Functional Testing**
   - [ ] Game starts without errors
   - [ ] All scenes load correctly
   - [ ] No console warnings/errors
   - [ ] Feature works as intended

2. **Regression Testing**
   - [ ] Existing features still work
   - [ ] No broken references
   - [ ] No missing assets

3. **Performance**
   - [ ] No significant FPS drops
   - [ ] Memory usage is reasonable
   - [ ] No memory leaks

## Common Tasks

### Adding a New Scene
1. Create `.tscn` file in `scenes/`
2. Add associated `.gd` script in `scripts/`
3. Update `main.gd` if it's a main scene
4. Update README.md structure if needed

### Adding New Assets
1. Place images in `assets/images/`
2. Place audio in `assets/sfx/`
3. Ensure assets are optimized
4. Use `.gitignore` for large files

### Fixing Bugs
1. Create branch: `git checkout -b fix/bug-name`
2. Make minimal changes
3. Add test case if applicable
4. Document the fix in PR description

## Questions?

- Open an [Issue](../../issues) with question tag
- Check [Godot Documentation](https://docs.godotengine.org)
- Review existing code for patterns

## Recognition

Contributors will be recognized in:
- CONTRIBUTORS.md file
- Project commit history
- Release notes (for major contributions)

## License

By contributing, you agree that your contributions will be licensed under the MIT License.

---

Thank you for making The Last Hatchling better! 🐉✨
