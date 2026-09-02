# Infected Desire - Quick Reference Card

## 🎮 Essential Hotkeys
```
F5          Play project
F6          Play scene
F7          Play custom scene
Escape      Stop running
Ctrl+Shift+F12  Toggle debugger
```

## 🎯 Main Entry Points
| File | Purpose |
|------|----------|
| res://scenes/Main.tscn | Main menu (load first) |
| res://scenes/Prologue.tscn | Story introduction |
| res://scenes/levels/Level01.tscn | First game level |
| res://scenes/player/Player.tscn | Player controller |
| res://scenes/ui/HUD.tscn | Heads-up display |

## 🚀 Quick Command Reference

### Load a Scene
```gdscript
get_tree().change_scene("res://scenes/Main.tscn")
```

### Get Player
```gdscript
var player = get_tree().get_first_node_in_group("player")
```

### Emit Signal
```gdscript
GlobalSignals.emit_signal("player_hp_changed", 50, 100)
```

### Change Language
```gdscript
LocalizationManager.set_language("en")
```

### Pause Game
```gdscript
get_tree().paused = true
```

### Save Data
```gdscript
SaveManager.save_game({"level": 1})
```

### Load Data
```gdscript
var data = SaveManager.load_game()
```

## 📊 Key Scenes
```
Main Menu
    ↓
Settings / Start Game
    ↓
Prologue (12 screens)
    ↓
Level 01 (Forest)
    ↓
Levels 02-04
    ↓
Ending / Game Over
```

## 🎨 Sprite Placeholder Resolution
- Player: 64×64 or 32×64
- Goblin: 48×48
- Orc: 64×128
- Projectiles: 16×16
- Effects: 64×64

## 🔊 Audio Bus Structure
```
Master
├── Music (sfx volume -5 dB default)
├── SFX (sfx volume -5 dB default)
└── Voice (voice volume -5 dB default)
```

## 💾 Save Data Structure
```json
{
    "current_level": 1,
    "checkpoint": "forest_01",
    "pregnancy": 30,
    "unlocked_abilities": [],
    "defeated_bosses": [],
    "language": "en",
    "censorship_enabled": true,
    "master_volume": 0.0
}
```

## 🎯 State Machine Quick Reference
```
Player States:
  IDLE       → standing still
  RUN        → moving horizontally
  JUMP       → ascending
  FALL       → descending
  ATTACK     → melee attack
  MAGIC      → spell casting
  DASH       → quick movement
  HURT       → taking damage

Transitions based on input and physics.
```

## 🔌 Signal Events
```gdscript
# Player signals
player_hp_changed(hp, max_hp)
player_stamina_changed(stamina, max_stamina)
player_pregnancy_changed(pregnancy, max_pregnancy)
player_defeated(attacker_type)
player_recovered

# Level signals
level_loaded(level_name)
level_complete

# Enemy signals
enemy_spawned(enemy)
enemy_died(enemy)

# Game state signals
game_paused
game_resumed
game_over(pregnancy)
```

## 🎮 Input Actions
```
ui_left     Move left
ui_right    Move right
jump        Jump/Ascend
attack      Physical attack
magic       Cast spell
dash        Quick dash
interact    Interact with NPCs
pause       Pause/Resume game
```

## 🐛 Debug Prints
```gdscript
print("Debug: ", variable)
push_error("Error: ", issue)
push_warning("Warning: ", caution)
```

## 📁 Directory Shortcuts
```
[Project Root]
  ├─ scenes/          Main game scenes
  ├─ scripts/         GDScript code
  ├─ assets/          Sprites, audio, etc
  └─ project.godot    Config file
```

## ⚙️ Important Classes
```gdscript
PlayerStats        # Health, stamina, pregnancy
PlayerStateMachine # State management
Enemy              # Base enemy class
FireMagic          # Spell casting
GlobalSignals      # Event system
SaveManager        # Persistence
LocalizationManager # Multi-language
AudioManager       # Sound control
```

## 🎓 Common Mistakes to Avoid
```
❌ Hardcoding player position
✅ Use get_tree().get_first_node_in_group("player")

❌ Direct variable changes
✅ Use signals for UI updates

❌ Creating new autoloads in scenes
✅ Add to project settings already

❌ Forgetting to localize text
✅ Always use LocalizationManager

❌ Not handling null references
✅ Always check if node exists first
```

## 🚀 Next Development Steps
1. Add sprite sheets for animations
2. Create tileset images
3. Record/import sound effects
4. Design additional levels
5. Implement boss battles
6. Create full prologue cinematics
7. Add visual effects
8. Test on target hardware

---

**Version**: 1.0  
**Engine**: Godot 3.6  
**Date**: September 2026  
