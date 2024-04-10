extends TileMap

# Member variables for the tileset
var wall_tile_id = 0
var floor_tile_id = 1

func _ready():
    # Initialize the grid with floor tiles
    for x in range(10):
        for y in range(10):
            set_cell(x, y, floor_tile_id)

func add_wall_at_position(x, y):
    set_cell(x, y, wall_tile_id)

func remove_wall_at_position(x, y):
    set_cell(x, y, floor_tile_id)
