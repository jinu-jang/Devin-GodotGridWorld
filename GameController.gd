extends Node

var good_guy_scene = preload("res://GoodGuy.tscn")
var bad_guy_scene = preload("res://BadGuy.tscn")
var coin_scene = preload("res://Coin.tscn")
var tilemap_node

func _ready():
    tilemap_node = get_node("TileMap") # Assuming the TileMap node is at this path
    spawn_good_guys(2)
    spawn_bad_guys(2)
    spawn_coins(10)

func spawn_good_guys(amount):
    for i in range(amount):
        var good_guy = good_guy_scene.instance()
        add_child(good_guy)
        good_guy.position = get_random_walkable_position()

func spawn_bad_guys(amount):
    for i in range(amount):
        var bad_guy = bad_guy_scene.instance()
        add_child(bad_guy)
        bad_guy.position = get_random_walkable_position()

func spawn_coins(amount):
    for i in range(amount):
        var coin = coin_scene.instance()
        add_child(coin)
        coin.position = get_random_walkable_position()

func get_random_walkable_position():
    var position = Vector2()
    var walkable = false
    while not walkable:
        position.x = int(rand_range(0, tilemap_node.get_used_rect().size.x))
        position.y = int(rand_range(0, tilemap_node.get_used_rect().size.y))
        var tile_id = tilemap_node.get_cellv(position)
        walkable = tile_id != tilemap_node.tile_set.find_tile_by_name("Wall")
    return position * tilemap_node.cell_size
