extends "res://addons/gut/test.gd"

var AStar = preload("res://AStar.gd")

func test_astar_finds_path():
    var astar = AStar.new()
    var grid_size = Vector2(10, 10)

    # Set up a grid with walkable tiles and an obstacle
    for x in range(grid_size.x):
        for y in range(grid_size.y):
            var walkable = true
            if x == 5 and y != 9: # Create a vertical wall except at the top
                walkable = false
            if walkable:
                astar.add_point(x * grid_size.y + y, Vector2(x, y), 1) # The weight for walking is 1

    # Set start and end points
    var start_id = 0 # Bottom left corner
    var end_id = 99 # Top right corner

    # Find the path
    var path = astar.get_path(start_id, end_id)

    # Check if a path was found
    assert_ne(path.size(), 0)
    # Check if the path starts at the start position
    assert_eq(path[0], Vector2(0, 0))
    # Check if the path ends at the end position
    assert_eq(path[path.size() - 1], Vector2(9, 9))
