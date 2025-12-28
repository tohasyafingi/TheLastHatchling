# Development Setup & Guidelines

## Quick Start for Developers

### Environment Setup

1. **Install Godot 4.0+**
   - Download from [godotengine.org](https://godotengine.org/download)
   - Minimum: Godot 4.0
   - Recommended: Latest stable version

2. **Clone and open project**
   ```bash
   git clone https://github.com/yourusername/dragon.git
   cd dragon
   ```

3. **Open in Godot**
   - Launch Godot
   - Select "Open Project"
   - Navigate to the `project.godot` file
   - Click Open

4. **Run the game**
   - Press `F5` or click the Play button
   - Game should start with splash screen

## Project Architecture

### Scene Hierarchy

```
Main (main.tscn)
├── Splash (splash.tscn)
├── Home (home.tscn)
└── Level1 (level1.tscn)
    ├── Player (player.tscn)
    ├── Enemies (enemy.tscn)
    ├── Collectibles (collectible.tscn)
    ├── TileMap
    ├── UI (ui.tscn)
    └── Camera2D
```

### Script Organization

**Main Flow:**
- `main.gd` - Scene manager, handles transitions
- `splash.gd` - Splash screen auto-advance and skip logic
- `home.gd` - Menu navigation

**Game Logic:**
- `game_manager.gd` - Global state, audio management
- `player.gd` - Player physics, input, combat
- `enemy.gd` - Enemy AI and movement
- `collectible.gd` - Item collection logic

**UI & Audio:**
- `ui.gd` - Health bar, HUD updates
- Audio managed through game_manager

## Key Directories

| Directory | Purpose | Notes |
|-----------|---------|-------|
| `scenes/` | All .tscn files | Main game scenes and components |
| `scripts/` | All .gd files | Game logic and behaviors |
| `assets/images/` | Sprite sheets, tilesets | PNG format, 32x32 tiles |
| `assets/sfx/` | Audio files | MP3 (music), WAV (SFX) |

## Common Development Tasks

### Adding a New Enemy Type

1. **Create enemy variant**
   ```gdscript
   # scripts/enemy_flying.gd
   extends "res://scripts/enemy.gd"
   
   func _ready():
       super()
       velocity.y = -50  # Start flying upward
   
   func _physics_process(delta):
       # Custom flight pattern
       velocity.y += sin(Time.get_ticks_msec() * 0.003) * 100
       super._physics_process(delta)
   ```

2. **Add to level scene**
   - Duplicate existing enemy
   - Attach new script
   - Position in level

### Adding a New Collectible

1. **Create collectible variant**
   ```gdscript
   # scripts/collectible_speed_boost.gd
   extends "res://scripts/collectible.gd"
   
   func apply_effect(player: Node2D) -> void:
       player.speed *= 1.5
       await get_tree().create_timer(5.0).timeout
       player.speed /= 1.5
   ```

2. **Add to scene and test**

### Extending the Level

1. **Edit level1.tscn**
   - Add more platforms using TileMap
   - Place enemies and collectibles
   - Adjust difficulty

2. **Test progression**
   - Run game and play through
   - Check for difficulty curve
   - Adjust enemy placement

### Adding New Audio

1. **Import audio file**
   - Place `.mp3` or `.wav` in `assets/sfx/`
   - Godot auto-imports

2. **Play in code**
   ```gdscript
   # In game_manager.gd or any scene
   var sound = AudioStreamPlayer.new()
   sound.stream = load("res://assets/sfx/jump.wav")
   add_child(sound)
   sound.play()
   ```

## Debugging Tips

### Enable Debug Console

Press `F8` during gameplay to open console and see:
- Error messages
- Print statements
- Performance metrics

### Useful Debug Commands

```gdscript
# In any script
print("Message")                    # Console output
print_debug("Debug info")           # Formatted output
push_error("Error message")         # Error message
push_warning("Warning message")     # Warning message

# Check node tree
print(get_tree().root)              # Print scene tree

# Performance monitoring
print(Engine.get_frames_drawn())    # Frame count
print(OS.get_static_memory_usage()) # Memory usage
```

### Common Issues

| Issue | Solution |
|-------|----------|
| Scene won't load | Check file paths in scripts |
| Script errors | Check node names match @onready declarations |
| Missing assets | Verify files in assets/ folders |
| Performance lag | Check for infinite loops, too many Physics bodies |
| Audio not playing | Ensure audio files are in correct format |

## Performance Optimization

### Best Practices

1. **Limit active enemies** - Disable off-screen enemies
   ```gdscript
   if not is_on_screen():
       process_mode = Node.PROCESS_MODE_DISABLED
   ```

2. **Use object pooling** - Reuse bullets, particles
   ```gdscript
   # Instead of creating new objects each time
   var bullet_pool = []
   
   func _get_bullet():
       if bullet_pool.is_empty():
           return Bullet.new()
       return bullet_pool.pop_back()
   ```

3. **Optimize collisions** - Use appropriate collision shapes
   ```gdscript
   # Use simple shapes, not complex meshes
   # Prefer RectangleShape2D > CapsuleShape2D > Polygon2D
   ```

4. **Batch rendering** - Group similar objects
   ```gdscript
   # Use CanvasGroup for common transformations
   # Avoid multiple z-index changes
   ```

## Testing Workflow

### Before Committing

```bash
# 1. Run game and test your changes
# Press F5 in Godot

# 2. Check console for errors
# Press F8 to open debug console

# 3. Verify no regressions
# Test existing features still work

# 4. Commit if all good
git add .
git commit -m "feat: add new feature"
```

### Automated Testing (Optional)

Godot supports GDUnit for unit testing:
```gdscript
class_name TestPlayer
extends GdUnitTestSuite

func test_player_jump_velocity() -> void:
    var player = Player.new()
    player.jump()
    assert_that(player.velocity.y).is_less_than(0)
```

## Resources

- [Godot 4 Documentation](https://docs.godotengine.org/en/stable/index.html)
- [GDScript Reference](https://docs.godotengine.org/en/stable/getting_started/scripting/gdscript/index.html)
- [Godot Community Forum](https://forum.godotengine.org)
- [Godot Discord](https://discord.gg/godotengine)

## Useful Tools

- **Godot Inspector** - Inspect node properties and values
- **Script Editor** - Write and debug code
- **Scene Debugger** - Visualize scene tree and properties
- **Profiler** - Monitor performance

## Next Steps

1. **Create a feature branch** - `git checkout -b feature/my-feature`
2. **Make your changes** - Edit scenes and scripts
3. **Test thoroughly** - Run the game, check console
4. **Commit and push** - `git push origin feature/my-feature`
5. **Create pull request** - Submit your changes for review

Happy coding! 🐉✨
