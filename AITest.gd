# AITest.gd
# This script will simulate the game's logic to test the AI strategies.

extends Node

var good_guy_scene = preload("res://GoodGuy.tscn")
var bad_guy_scene = preload("res://BadGuy.tscn")
var game_controller_scene = preload("res://GameController.tscn")
var game_controller

func _ready():
    game_controller = game_controller_scene.instance()
    add_child(game_controller)
    # Run the simulation for a set number of iterations
    simulate_game(10)

func simulate_game(iterations):
    for i in range(iterations):
        # Call the _physics_process method of each NPC to simulate their behavior
        for good_guy in get_tree().get_nodes_in_group("good_guys"):
            good_guy._physics_process(0.016) # Assuming a frame rate of 60 FPS
            print("Good Guy Position: ", good_guy.position)
        for bad_guy in get_tree().get_nodes_in_group("bad_guys"):
            bad_guy._physics_process(0.016) # Assuming a frame rate of 60 FPS
            print("Bad Guy Position: ", bad_guy.position)
        # Print the iteration number
        print("Iteration: ", i + 1)
