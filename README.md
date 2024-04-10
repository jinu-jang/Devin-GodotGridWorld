# Grid World AI Testbed

## Introduction
This project is a 2D grid world game developed in Godot 4.2.1, designed to test different AI strategies for moving characters around the world. The game features traversable and non-traversable wall tiles, spawnable good guys and bad guys, and coins for the good guys to collect. The map is customizable, allowing for the addition and deletion of wall tiles. AI strategies can be swapped easily for testing different movement behaviors.

## Setup
To set up the project, follow these steps:
1. Ensure Godot 4.2.1 is installed on your system.
2. Clone the repository to your local machine.
3. Open the project in Godot by selecting the `project.godot` file.
4. To run the game, press the 'Play' button in the Godot editor or execute the game from the command line using the following command:
   ```
   godot --no-window --path . --script AITestHarness.gd
   ```
5. To run AI simulations outside of Godot, ensure Python 3.10.12 is installed and execute the `ai_simulation.py` script:
   ```
   python3 ai_simulation.py
   ```

## AI Strategies
The project includes several AI strategies for NPCs:
- `RandomMovementAI`: NPCs move in random directions.
- `AStarMovementAI`: NPCs use the A* search algorithm to find the shortest path to their target.

## Swapping AI Strategies
To swap AI strategies for an NPC, modify the `ai_strategy` property in the NPC's script. For example, to use the A* movement AI:
```gdscript
var ai_strategy = load("res://AStarMovementAI.gd").new()
```

## Testing AI Strategies
To test AI strategies, you can use the `AITestHarness.gd` script to simulate the game's logic and log the results to a file for validation. Alternatively, run the `ai_simulation.py` Python script for a non-graphical simulation of the AI behavior.

## Customizing the Map
The map can be customized by adding or removing wall tiles using the `TileMap.gd` script. Use the following functions to modify the grid:
- `add_wall_tile(x, y)`: Adds a wall tile at the specified coordinates.
- `remove_wall_tile(x, y)`: Removes a wall tile at the specified coordinates.

## Conclusion
This grid world game serves as a testbed for experimenting with and validating various AI strategies in a controlled environment. It provides a flexible platform for AI research and development.
