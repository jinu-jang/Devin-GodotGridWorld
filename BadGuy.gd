extends KinematicBody2D

var speed = 80
var velocity = Vector2()
var target_good_guy = null
var path = []
var current_path_index = 0
var astar_script = preload("res://AStar.gd")
var astar = astar_script.new()
var grid_size = Vector2(10, 10) # Assuming a 10x10 grid for simplicity
var tilemap_node = null

func _ready():
    # Find all good guys in the scene and select the closest one as the target
    var good_guys = get_tree().get_nodes_in_group("good_guys")
    var closest_distance = INF
    for good_guy in good_guys:
        var distance = position.distance_to(good_guy.position)
        if distance < closest_distance:
            closest_distance = distance
            target_good_guy = good_guy
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
    if path.size() == 0 or current_path_index >= path.size():
        # If there is no path or we've reached the end of the path, find a new path
        path = astar.a_star(position, target_good_guy.position)
        current_path_index = 0

    if path.size() > 0:
        # Follow the path
        var target_position = path[current_path_index]
        var direction = (target_position - position).normalized()
        velocity = direction * speed
        move_and_slide(velocity)

        if position.distance_to(target_position) < 1:
            # Move to the next point in the path
            current_path_index += 1
    else:
        velocity = Vector2.ZERO # Reset velocity if no path
