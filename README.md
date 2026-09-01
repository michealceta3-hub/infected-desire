# Infected Desire — Game Development Project

## Overview

**Infected Desire** is a dark fantasy 2D action platformer developed with Godot Engine 3.6. The game features a mature female protagonist with fire magic abilities, navigating a corrupted world while searching for her husband and attempting to stop the spread of a magical infection.

## Project Structure

```
res://
├── scenes/
│   ├── Main.tscn (Main Menu)
│   ├── Prologue.tscn (Story Introduction)
│   ├── player/
│   │   └── Player.tscn
│   ├── enemies/
│   │   ├── Goblin.tscn
│   │   └── Orc.tscn
│   ├── levels/
│   │   └── Level01.tscn (Forgotten Forest)
│   ├── ui/
│   │   ├── HUD.tscn
│   │   ├── Settings.tscn
│   │   ├── GameOver.tscn
│   │   └── DefeatCensored.tscn
│   └── effects/
│       └── FireShot.tscn
├── scripts/
│   ├── systems/
│   │   ├── GlobalSignals.gd (Event system)
│   │   ├── SaveManager.gd (Save/Load system)
│   │   ├── AudioManager.gd (Audio control)
│   │   └── LocalizationManager.gd (Multi-language support)
│   ├── player/
│   │   ├── Player.gd (Main player script)
│   │   ├── PlayerStats.gd (Health/Stamina/Pregnancy)
│   │   ├── PlayerStateMachine.gd (State management)
│   │   ├── PlayerState.gd (Base state class)
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
│   │   ├── Enemy.gd (Base enemy)
│   │   ├── Goblin.gd
│   │   └── Orc.gd
│   ├── ui/
│   │   ├── HUD.gd
│   │   ├── MainMenu.gd
│   │   ├── Settings.gd
│   │   └── GameOver.gd
│   ├── effects/
│   │   └── FireShot.gd
│   └── levels/
│       └── Level01.gd
├── assets/
│   ├── sprites/
│   ├── animations/
│   ├── audio/
│   └── icon.png
└── project.godot (Project configuration)
```

## Core Systems

### 1. Player System
- **Player.gd**: Main player controller with KinematicBody2D
- **PlayerStats.gd**: Manages HP (100), Stamina (100), Pregnancy/Infection meter (0-100%)
- **PlayerStateMachine.gd**: Manages player states (IDLE, RUN, JUMP, FALL, ATTACK, MAGIC, DASH, HURT)

### 2. Combat System
- **Fire Magic**: Fire Shot, Flame Burst, Flame Wave, Flame Dash, Inferno
- **Attack States**: Smooth transitions between combat actions
- **Stamina Cost**: Each ability consumes stamina
- **Knockback**: Enemies apply knockback on hit

### 3. Enemy AI
- **Base Enemy.gd**: Patrol → Detect → Chase → Attack state machine
- **Goblin**: Fast, weak, attacks in groups (30 HP, 10 damage)
- **Orc**: Slow, strong, high HP (80 HP, 25 damage)

### 4. Defeat System
- When player HP reaches 0, the last attacker type is recorded
- Appropriate defeat scene plays (censored or uncensored)
- Player respawns with full HP
- Infection meter increases by 10%
- Game Over triggered at 100% infection

### 5. Localization System
- **Supports**: Russian (RU), English (EN), Romanian (RO)
- **LocalizationManager.gd**: Centralized text management
- **Dynamic Language Switching**: Change language without restarting

### 6. Save System
- **SaveManager.gd**: Handles save/load with ConfigFile
- **Saves**:
  - Current level progress
  - Checkpoints
  - Pregnancy meter
  - Unlocked abilities
  - Defeated bosses
  - Settings

### 7. Audio System
- **AudioManager.gd**: Volume control (Master, Music, SFX, Voice)
- **Audio Buses**: Properly configured for game audio

## Gameplay Mechanics

### Player Controls
- **Move Left/Right**: A / D or Arrow Keys
- **Jump**: W / Spacebar
- **Attack**: Left Mouse / X
- **Magic**: Right Mouse / Z
- **Dash**: Shift / C
- **Interact**: E
- **Pause**: ESC

### Health System
```
HP = 100 (recovers after defeat)
Defeat → Pregnancy +10%
Pregnancy >= 100% → GAME OVER
```

### Stamina System
```
Stamina = 100 (regenerates at 50/sec when idle)
Run: -1/sec
Dash: -25
Magic: -20
Attack: -15
```

### Pregnancy/Infection System
```
0% - 10% - 20% - 30% - 40% - 50% - 60% - 70% - 80% - 90% - 100%
Progress increases after each defeat
Critical at 100% = Game Over
```

## Features

✅ **Complete State Machine**: Player and enemies use FSM for behavior
✅ **Modular Architecture**: Systems are independent and extendable
✅ **Signal-Based Communication**: Global events for UI updates
✅ **Multi-Language Support**: Automatic text localization
✅ **Censorship Toggle**: Adult content can be hidden with one setting
✅ **Dynamic Difficulty**: Pregnancy meter affects game state
✅ **Enemy Variety**: Different enemy types with unique behaviors
✅ **Platformer Movement**: Smooth jumping, dashing, and falling
✅ **Fire Magic System**: Multiple spell types with different costs
✅ **HUD System**: Real-time health, stamina, and infection display

## How to Use

### 1. Open in Godot 3.6
```bash
godot --path infected-desire
```

### 2. Run the Project
- Click "Play" (F5) to start
- Main menu appears first
- Click "START GAME" to begin Prologue
- After prologue, Level 01 loads

### 3. Configure Settings
- Open Settings menu
- Change language, censorship, and audio
- Settings save automatically

### 4. Develop Further
- Add new levels in `res://scenes/levels/`
- Create new enemies by extending `Enemy.gd`
- Add new states to `StateMachine`
- Extend fire magic with new spells in `FireMagic.gd`
- Create boss encounters with unique patterns

## Story Overview

### Prologue
Two powerful wizards were married despite the husband's intimate difficulties. He created an experimental enhancement potion but had an accident. The potion became a sentient magical infection that spreads through intimate contact, corrupting all it touches.

### Main Campaign
The heroine searches for her infected husband across corrupted lands:
- **Level 01**: Forgotten Forest (Goblins)
- **Level 02**: Abandoned Village (Survivors, Orcs)
- **Level 03**: Ruined Road (Infected)
- **Level 04**: Orc Fortress (Boss)

### Endings
Multiple endings based on:
- Pregnancy meter level
- Dialogue choices
- Optional objectives completed

## Development Progress

- [x] Project structure
- [x] Core systems (Signals, Save, Audio, Localization)
- [x] Player controller and state machine
- [x] Enemy AI (Goblin, Orc)
- [x] HUD system
- [x] Defeat system with censorship
- [x] Fire magic (basic)
- [ ] Level 01 complete implementation
- [ ] Boss encounters
- [ ] Prologue scenes and animations
- [ ] Sound effects and music
- [ ] Character animations
- [ ] Visual effects (fire, explosions, etc.)
- [ ] Additional levels (02, 03, 04)
- [ ] Dialogue system implementation
- [ ] Final story and endings

## Technical Details

- **Engine**: Godot 3.6 Stable
- **Language**: GDScript
- **Resolution**: 1920×1080
- **Platform**: Windows PC
- **Physics**: KinematicBody2D with TileMap
- **Graphics**: 2D Sprite-based with particle effects
- **Age Rating**: 18+ (content adjustable via settings)

## Notes for Developers

1. **Use GlobalSignals for communication** between systems
2. **Always create separate state files** rather than monolithic scripts
3. **Extend base classes** (Enemy, PlayerState) for new content
4. **Save to user:// directory** for persistence
5. **Localize all text** through LocalizationManager
6. **Test with censorship enabled/disabled** for adult content

---

**Project initialized with complete architecture ready for expansion.**
