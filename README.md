# The Last Hatchling 🐉

A 2D platformer adventure game built with Godot 4, where you must collect crystals, avoid enemies, and save the last hatchling from extinction.

**▶️ [Play now on itch.io](https://toha-syafingi.itch.io/the-last-hatchling)**

## Features

- **Exploration & Platforming**: Navigate through cave environments with smooth physics-based movement
- **Resource Collection**: Gather crystals scattered throughout levels
- **Enemy Avoidance**: Dodge various enemies with intelligent patrol patterns
- **Dynamic Audio**: Background music and sound effects for each action
- **Progressive Levels**: Multiple levels with increasing difficulty
- **Responsive Controls**: Smooth keyboard and input handling

## Gameplay Mechanics

- **Movement**: A/D or Arrow keys to move left/right
- **Jump**: Space bar to jump
- **Attack**: Enter key to attack enemies
- **Collection**: Automatically collect crystals when you touch them
- **Health System**: Avoid enemies and hazards to survive
- **Touch Controls**: Available on mobile platforms (directional buttons + action buttons)

## Project Structure

```
TheLastHatchling/
├── scenes/                    # All game scenes
│   ├── splash.tscn            # Splash/intro screen
│   ├── home.tscn              # Main menu screen
│   ├── level1.tscn            # Level 1 
│   ├── level2.tscn            # Level 2
│   ├── level3.tscn            # Level 3
│   ├── level4.tscn            # Level 4
│   ├── level5.tscn            # Level 5
│   ├── player.tscn            # Player character
│   ├── enemy.tscn             # Enemy entities
│   ├── collectible.tscn       # Crystal items
│   ├── death_zone.tscn        # Hazard zones
│   ├── touch_controls.tscn    # Mobile touch UI
│   └── ui.tscn                # UI elements
├── scripts/                   # All GDScript files
│   ├── main.gd                # Main scene manager
│   ├── splash.gd              # Splash screen logic
│   ├── home.gd                # Home menu logic
│   ├── player.gd              # Player movement & combat
│   ├── game_manager.gd        # Game state management
│   ├── enemy.gd               # Enemy behavior
│   ├── touch_controls.gd      # Touch input handling
│   ├── level1_animator.gd     # Background animation
│   ├── level2_animator.gd     # Background animation
│   └── [other scripts]
├── assets/
│   ├── player/                # Player sprites
│   ├── level1/ - level5/      # Level-specific assets
│   ├── control/               # Touch control button images
│   ├── music/                 # Background music (OGG format)
│   │   └── sfx/               # Sound effects
│   └── [other assets]
├── export_presets.cfg         # Export configurations
├── project.godot              # Godot project configuration
├── LICENSE                    # MIT License
└── README.md                  # This file
```

## Getting Started

### Prerequisites
- Godot 4.5 or higher
- Operating System: Windows, macOS, Linux, or Android
- For Web: Modern browser with WebAssembly support

### Installation

1. Clone this repository:
```bash
git clone https://github.com/tohasyafingi/TheLastHatchling.git
cd TheLastHatchling
```

2. Open the project in Godot 4.5:
   - Launch Godot 4.5
   - Click "Open Project" and select the `project.godot` file

3. Press F5 or click the Play button to run the game

## Export Options

The game supports export to multiple platforms:

### Desktop (Windows, Linux, macOS)
```bash
# In Godot Editor: Project → Export → Windows Desktop/Linux/macOS
```

### Web
```bash
# In Godot Editor: Project → Export → Web
# Requires modern browser with WebAssembly support
```

### Android
```bash
# In Godot Editor: Project → Export → Android
# Requires Android SDK and development environment setup
# APK will be generated in build/android/ folder
```

## Controls

| Key | Action |
|-----|--------|
| A / Left Arrow | Move Left |
| D / Right Arrow | Move Right |
| Space | Jump |
| Enter | Attack |
| ESC | Back/Menu |

### Mobile Controls
- **Left/Right Buttons**: Move left or right
- **Jump Button** (Bottom-Right): Jump
- **Attack Button** (Top-Right): Attack enemies

## Game Flow

1. **Splash Screen**: Intro screen with game title (3 seconds or press any key)
2. **Home Screen**: Main menu - Choose to Start or Quit
3. **Level**: Main gameplay with platforms, enemies, and collectibles
4. **Level Complete**: Victory screen with stats
5. **Game Over**: Option to restart or return to menu

## Development

### Building from Source
- Written in **GDScript** (Godot's native scripting language)
- Uses **Godot 4.0+** features and best practices
- Modular scene structure for easy maintenance

### Key Files
- `main.gd` - Manages scene transitions (splash → home → level)
- `game_manager.gd` - Handles game state and audio
- `player.gd` - Player movement, jumping, and combat
- `splash.gd` - Auto-advance splash screen
- `home.gd` - Menu navigation

### Adding New Levels
1. Duplicate an existing level scene (e.g., `level1.tscn`)
2. Modify the tilemap and enemy/collectible placement
3. Update `main.gd` to load the new level
4. Test thoroughly!

## Game Design

### Difficulty Progression
- **Level 1**: Introduction with basic platforming, no combat
- **Level 2+**: Progressively harder with enemies and more complex layouts

### Enemy AI
- Enemies patrol predetermined paths
- Collision with enemy deals damage
- Player can attack with Space key

### Collectibles
- Crystals restore health and increase score
- Visual feedback with particles and sound effects

## System Requirements

- **Minimum**: Intel i3 / AMD Ryzen 3, 4GB RAM, OpenGL 3.0+
- **Recommended**: Intel i5 / AMD Ryzen 5, 8GB RAM, OpenGL 4.3+

## Credits

- **Engine**: Godot 4
- **Language**: GDScript
- **Assets**: Custom and open-source tilesets
- **Sound**: Background music and SFX included

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Contributing

Contributions are welcome! Please feel free to:
1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## Known Issues

- None currently reported

## Future Enhancements

- [x] Mobile touch controls support
- [x] Multiple levels with varied themes
- [x] Enemy AI and combat system
- [x] Background animations
- [ ] Boss battles
- [ ] Power-up system
- [ ] Leaderboard/scoring system
- [ ] Accessibility features
- [ ] Localization (multiple languages)

## Contact & Support

For questions, bug reports, or suggestions:
- Open an [Issue](https://github.com/tohasyafingi/TheLastHatchling/issues) on GitHub
- Email: tohasyafingi12@gmail.com

---

**Enjoy saving the last hatchling!** 🐉✨

Made with ❤️ using Godot 4.5 Engine
