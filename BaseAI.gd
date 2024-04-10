# BaseAI.gd
# This is the base class for AI strategies.

class_name BaseAI
extends Reference

# Method to be overridden by AI strategies for initialization.
func _init():
    pass

# Method to be overridden by AI strategies to update the NPC's state.
func update(delta, npc):
    pass

# Method to be overridden by AI strategies to handle pathfinding.
func get_path(start, end):
    pass


# RandomMovementAI.gd
# This AI strategy moves the NPC in random directions.

class RandomMovementAI extends BaseAI:

    func _init():
        pass

    func update(delta, npc):
        npc.velocity = Vector2(rand_range(-1, 1), rand_range(-1, 1)).normalized() * npc.speed

    func get_path(start, end):
        # Random movement AI does not use pathfinding.
        pass


# AStarMovementAI.gd
# This AI strategy uses the A* algorithm for pathfinding.

class AStarMovementAI extends BaseAI:

    var astar_script = preload("res://AStar.gd")
    var astar

    func _init():
        astar = astar_script.new()
        # Initialize the AStar grid here, similar to what's done in the NPC scripts.

    func update(delta, npc):
        # Use the A* algorithm to get the path and move the NPC along it.
        # Similar to the logic in the NPC scripts.

    func get_path(start, end):
        return astar.a_star(start, end)
