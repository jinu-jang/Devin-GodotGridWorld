extends KinematicBody2D

var speed = 100
var velocity = Vector2()
var ai_strategy = null
var astar_script = preload("res://AStar.gd")
var astar = astar_script.new()
var grid_size = Vector2(10, 10) # Assuming a 10x10 grid for simplicity
var tilemap_node = null

func _ready():
    # Example of setting the AI strategy to AStarMovementAI
    # This can be changed dynamically to use different AI strategies
    ai_strategy = load("res://AStarMovementAI.gd").new()
    ai_strategy._init()
    # Initialize AStar with the current grid
    tilemap_node = get_node("/root/TileMap") # Assuming the TileMap node is at this path
    initialize_astar()

func initialize_astar():
    # This function should initialize the AStar grid based on the current level
    for x in range(grid_size.x):
        for y in range(grid_size.y):
            var tile_id = tilemap_node.get_cell(x, y)
            var walkable = tile_id != tilemap_node.tile_set.find_tile_by_name("Wall")
            if walkable:
                astar.add_point(x * grid_size.y + y, Vector2(x, y), 1) # The weight for walking is 1

func _physics_process(delta):
    ai_strategy.update(delta, self)
