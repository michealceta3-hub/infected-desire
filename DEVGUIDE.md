# Godot 3.6 Infected Desire - Complete Project Structure

## Quick Start Guide

### 1. Installation
```bash
git clone https://github.com/michealceta3-hub/infected-desire.git
cd infected-desire
```

### 2. Open in Godot 3.6
- Launch Godot 3.6
- Click "Import"
- Navigate to the infected-desire folder
- Click "Import & Edit"

### 3. Run the Game
- Press F5 or click the Play button
- Main Menu will load
- Click "START GAME" to begin Prologue
- After prologue, Level 01 begins

## Project Features

### ✅ Complete Systems
- **Player Controller**: Full state machine with 8 states (IDLE, RUN, JUMP, FALL, ATTACK, MAGIC, DASH, HURT)
- **Combat System**: Fire magic with stamina costs and cooldowns
- **Enemy AI**: Goblin (fast/weak) and Orc (slow/strong) with patrol, chase, attack states
- **Health System**: HP (100), Stamina (100), Pregnancy/Infection (0-100%)
- **Defeat Mechanics**: Different scenes based on last attacker type
- **Localization**: Russian, English, Romanian support
- **Save System**: ConfigFile-based save/load
- **Audio Manager**: Master volume with bus control
- **HUD System**: Real-time bars for HP, Stamina, Pregnancy
- **Dialogue System**: Multi-language dialogue boxes
- **Settings Menu**: Language, censorship toggle, volume control

### ✅ Game Progression
- Prologue with story narrative
- 4+ levels planned (Forest, Village, Road, Fortress)
- Boss encounters
- Checkpoint system
- Progressive difficulty
- Multiple endings based on pregnancy meter

## Gameplay Mechanics

### Controls
| Action | Keys |
|--------|------|
| Move Left | A / ← |
| Move Right | D / → |
| Jump | W / Spacebar |
| Attack | Left Mouse / X |
| Magic | Right Mouse / Z |
| Dash | Shift / C |
| Interact | E |
| Pause | ESC |

### Player Stats
```
HP:        100/100 (recovers after defeat)
Stamina:   100/100 (regenerates at 50/sec)
Pregnancy: 0-100% (increases 10% per defeat)
```

### Combat System
- **Attack**: 15 stamina, melee damage
- **Fire Shot**: 20 stamina, ranged magic
- **Dash**: 25 stamina, quick movement
- **Magic**: Variable costs depending on spell

### Enemies
- **Goblin**: 30 HP, 10 damage, 150 speed (weak but fast)
- **Orc**: 80 HP, 25 damage, 80 speed (strong but slow)
- **Boss**: 200+ HP, multiple phases, unique attacks

## Development Guide

### Adding a New Level

1. Create scene in `res://scenes/levels/Level02.tscn`
2. Add TileMap, Player instance, Enemies, HUD
3. Create script `res://scripts/levels/Level02.gd`
4. Link in Main Menu or level progression

```gdscript
extends Node2D

func _ready():
    GlobalSignals.emit_signal("level_loaded", "Level 02 - Abandoned Village")
```

### Adding a New Enemy Type

1. Create `res://scenes/enemies/Zombie.tscn`
2. Create script extending `Enemy.gd`
3. Set custom stats, animations, AI

```gdscript
extends Enemy

func _ready():
    enemy_type = "zombie"
    max_hp = 50.0
    damage = 15.0
    move_speed = 120.0
    .
```

### Adding New Magic Spells

1. Add method to `FireMagic.gd`
2. Create projectile scene in `res://scenes/effects/`
3. Define damage, speed, cost in spell method

```gdscript
func cast_flame_burst(position: Vector2):
    if player_stats.use_stamina(30.0):
        # Spawn burst effect
        var burst = burst_scene.instance()
        add_child(burst)
        burst.global_position = position
```

### Localizing Text

1. Add text to `LocalizationManager.gd`
2. Add keys for all languages (ru, en, ro)
3. Use in code:

```gdscript
var text = LocalizationManager.get_text("menu_start")
```

## File Structure

```
res://
├── scenes/
│   ├── Main.tscn                 # Main menu
│   ├── Prologue.tscn             # Story intro
│   ├── Game.tscn                 # Main game loader
│   ├── player/Player.tscn
│   ├── enemies/Goblin.tscn
│   ├── enemies/Orc.tscn
│   ├── levels/Level01.tscn
│   ├── ui/HUD.tscn
│   ├── ui/Settings.tscn
│   ├── ui/GameOver.tscn
│   ├── ui/PauseMenu.tscn
│   ├── ui/DefeatCensored.tscn
│   ├── effects/FireShot.tscn
│   └── defeat/
│       ├── DefeatGoblin.tscn
│       └── DefeatOrc.tscn
├── scripts/
│   ├── systems/
│   │   ├── GlobalSignals.gd
│   │   ├── SaveManager.gd
│   │   ├── AudioManager.gd
│   │   ├── LocalizationManager.gd
│   │   ├── DialogueSystem.gd
│   │   └── CheckpointSystem.gd
│   ├── player/
│   │   ├── Player.gd
│   │   ├── PlayerStats.gd
│   │   ├── PlayerStateMachine.gd
│   │   ├── PlayerState.gd
│   │   ├── FireMagic.gd
│   │   └── states/
│   │       ├── IdleState.gd
│   │       ├── RunState.gd
│   │       ├── JumpState.gd
│   │       ├── FallState.gd
│   │       ├── AttackState.gd
│   │       ├── MagicState.gd
│   │       ├── DashState.gd
│   │       └── HurtState.gd
│   ├── enemies/
│   │   ├── Enemy.gd
│   │   ├── Goblin.gd
│   │   └── Orc.gd
│   ├── bosses/Boss.gd
│   ├── ui/
│   │   ├── HUD.gd
│   │   ├── MainMenu.gd
│   │   ├── Settings.gd
│   │   ├── SettingsMenu.gd
│   │   ├── GameOver.gd
│   │   ├── PauseMenu.gd
│   │   └── DialogueUI.gd
│   ├── effects/
│   │   ├── EffectManager.gd
│   │   ├── FireShot.gd
│   │   └── Projectile.gd
│   ├── levels/
│   │   ├── Level.gd
│   │   ├── Level01.gd
│   │   ├── LevelData.gd
│   │   └── GameManager.gd
│   ├── config/GameConfig.gd
│   └── Prologue.gd
├── assets/
│   ├── icon.png
│   ├── sprites/
│   ├── audio/
│   └── animations/
├── project.godot           # Project config
├── README.md
└── .gitignore
```

## Technical Specifications

- **Engine**: Godot 3.6 Stable
- **Language**: GDScript
- **Resolution**: 1920×1080 (Full HD)
- **Target Platform**: Windows PC
- **Physics**: KinematicBody2D with TileMap collisions
- **Graphics**: 2D Sprite-based with particle effects
- **Audio**: 3 buses (Master, Music, SFX)
- **Localization**: 3 languages (RU, EN, RO)
- **Saving**: ConfigFile format in user:// directory
- **Age Rating**: 18+ (configurable via censorship setting)

## Debug Tips

### Enable Debug Output
```gdscript
print("Debug message")
push_error("Error message")
push_warning("Warning message")
```

### Check Player State
```gdscript
print(player.state_machine.get_current_state())
```

### Monitor Signals
```gdscript
GlobalSignals.connect("player_defeated", self, "_debug_defeated")
```

### Test Defeat Scenes
- Use censorship toggle in Settings
- Hit ESC to pause and adjust settings mid-game

## Known Limitations

- Animations are placeholders (use AnimatedSprite without actual frames for now)
- Boss encounters not yet implemented
- Dialogue UI partially functional
- Some sound effects and music not included
- Character portraits not yet added

## Future Development

- [ ] Complete all 4 levels
- [ ] Boss encounters with phases
- [ ] Prologue animation sequences
- [ ] Full character animations
- [ ] Sound effects and music
- [ ] Visual effects (fire, smoke, particles)
- [ ] Dialogue tree system
- [ ] Multiple endings implementation
- [ ] New enemy types
- [ ] Power-up system
- [ ] Leaderboard/stats
- [ ] Controller support

## Contributors

- **Project Lead**: michealceta3-hub
- **Engine**: Godot Foundation

## License

This project is open source. See individual assets for licensing details.

## Support

For issues or questions:
- Check README.md
- Review existing code comments
- Test with simple debug prints
- Check Godot documentation

---

**Last Updated**: September 2026
**Godot Version**: 3.6 Stable
**Status**: Active Development
