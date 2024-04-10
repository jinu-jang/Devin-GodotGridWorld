extends "res://addons/gut/test.gd"

var GoodGuy = preload("res://GoodGuy.gd")

func test_good_guy_moves_towards_coin():
    var good_guy = GoodGuy.new()
    var start_position = Vector2(0, 0)
    var target_position = Vector2(10, 0) # Coin's position
    good_guy.position = start_position
    good_guy.target = target_position # Assuming GoodGuy.gd has a 'target' property for simplicity

    # Simulate one physics frame
    good_guy._physics_process(1.0 / 60.0)

    # Check if the good guy moved right towards the coin
    assert_eq(good_guy.position.x, start_position.x + good_guy.speed * (1.0 / 60.0))
    assert_eq(good_guy.position.y, start_position.y)
