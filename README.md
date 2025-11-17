# Top-Down RPG

A top-down farming RPG game built with Godot Engine featuring a player character with various tools and autonomous NPC characters.

## Features

### Player Character
- **Movement System**: 8-directional movement with smooth animations
- **Tool System**: Multiple tools with animations
  - Axe for chopping wood
  - Hoe for tilling ground
  - Watering can for watering crops
- **State Machine**: Clean state-based architecture for player behavior

### NPCs

#### Wandering Chicken
An autonomous chicken NPC with realistic behaviors:

**Behaviors:**
- **Idle State**: Rests between activities with subtle head bobbing
- **Wander State**: Randomly walks around the environment
- **Peck State**: Stops to peck at the ground
- **Flap State**: Flaps wings periodically
- **Bob State**: Bobs head while standing
- **Lay Egg State**: Periodically lays eggs that spawn in the game world
- **Squawk State**: Makes noise when the player approaches

**Features:**
- Proximity detection - reacts when player gets close
- Random behavior transitions for natural movement
- Spawns egg objects that persist for 30 seconds before fading
- Custom squawk sound effect
- Pixel art sprite with multiple animation frames

## Project Structure

```
Top-Down-RPG/
├── Assets/
│   ├── Chicken/                    # Chicken NPC assets
│   │   ├── chicken-sprite-sheet.png   # 32x32 sprite animations
│   │   ├── egg.png                     # Egg sprite
│   │   └── chicken-squawk.wav          # Squawk sound effect
│   ├── Elora's Art/               # Tileset and environment art
│   ├── Antarcticbees/             # Interior tileset
│   └── Farmer/                     # Player character sprites
├── Scenes/
│   ├── main.tscn                   # Main game scene
│   ├── player.tscn                 # Player character scene
│   ├── chicken.tscn                # Chicken NPC scene
│   └── egg.tscn                    # Egg object scene
└── Scripts/
    ├── state_machine/              # State machine implementation
    │   ├── node_state.gd           # Base state class
    │   ├── node_state_machine.gd   # State machine controller
    │   ├── player.gd               # Player character script
    │   ├── chicken.gd              # Chicken character script
    │   ├── chicken_idle_state.gd   # Chicken idle behavior
    │   ├── chicken_wander_state.gd # Chicken wandering behavior
    │   ├── chicken_peck_state.gd   # Chicken pecking behavior
    │   ├── chicken_flap_state.gd   # Chicken wing flapping
    │   ├── chicken_bob_state.gd    # Chicken head bobbing
    │   ├── chicken_lay_egg_state.gd # Egg laying behavior
    │   └── chicken_squawk_state.gd # Proximity alert behavior
    └── egg.gd                      # Egg object script
```

## Architecture

### State Machine Pattern
The game uses a hierarchical state machine pattern for character behavior:

1. **NodeState**: Base class for all states
   - Provides lifecycle hooks: `_on_enter()`, `_on_exit()`, `_on_process()`, `_on_physics_process()`
   - Emits transition signals to change states

2. **NodeStateMachine**: Manages state transitions
   - Registers child states automatically
   - Handles transitions between states
   - Calls appropriate lifecycle methods

3. **Character Scripts**: Extend CharacterBody2D
   - Contain character-specific data and helper methods
   - Referenced by state scripts for behavior implementation

### Adding New NPCs

To add a new NPC following this pattern:

1. Create a character script extending CharacterBody2D
2. Create state scripts for each behavior, extending NodeState
3. Set up AnimatedSprite2D with required animations
4. Create a scene with:
   - CharacterBody2D root node with character script
   - AnimatedSprite2D for visuals
   - CollisionShape2D for physics
   - Node with NodeStateMachine script
   - Child nodes for each state with appropriate scripts
5. Configure state transitions in state scripts

## Asset Creation

All chicken assets were procedurally generated:
- **Sprite Sheet**: 192x128 pixels (6 columns × 4 rows of 32x32 frames)
  - Row 0: Walk animation (4 frames) + Peck animation (2 frames)
  - Row 1: Flap animation (4 frames) + Bob animation (2 frames)
  - Row 2: Lay egg animation (4 frames) + Squawk animation (2 frames)
  - Row 3: Idle animation (4 frames)
- **Egg Sprite**: 16x16 pixels, off-white color
- **Squawk Sound**: 0.3 second frequency-modulated chirp (1500Hz → 800Hz)

## Development

### Requirements
- Godot Engine 4.x
- Python 3 with Pillow (for asset generation scripts)

### Building and Running
1. Open the project in Godot Engine
2. Press F5 to run the game
3. Use arrow keys or WASD to move the player
4. Watch the chickens wander and interact!

## Future Enhancements

Potential additions:
- More NPC types with unique behaviors
- Interaction system for feeding/catching chickens
- Crop growing system with watering mechanics
- Day/night cycle affecting NPC behavior
- Save/load game state
- Inventory system
- Crafting mechanics

## Credits

- Character sprites: Various sources in Assets folder
- Tilesets: Elora's Art, Antarcticbees
- State machine architecture: Custom implementation
- Chicken sprites and sounds: Procedurally generated

## License

[Add your license information here]
