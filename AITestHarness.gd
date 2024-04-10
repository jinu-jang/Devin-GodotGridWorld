# AITestHarness.gd
# This script will simulate the game's logic and log the results to validate the AI behavior.

extends Node

var good_guy_scene = preload("res://GoodGuy.tscn")
var bad_guy_scene = preload("res://BadGuy.tscn")
var game_controller_scene = preload("res://GameController.tscn")
var game_controller
var log_file_path = "res://ai_test_log.txt"
var log_file

func _ready():
    game_controller = game_controller_scene.instance()
    add_child(game_controller)
    open_log_file()
    # Run the simulation for a set number of iterations
    simulate_game(10)
    close_log_file()

func open_log_file():
    log_file = File.new()
    log_file.open(log_file_path, File.WRITE)

func log_message(message):
    log_file.store_string(message + "\n")

func close_log_file():
    log_file.close()

func simulate_game(iterations):
    for i in range(iterations):
        # Call the _physics_process method of each NPC to simulate their behavior
        for good_guy in get_tree().get_nodes_in_group("good_guys"):
            good_guy._physics_process(0.016) # Assuming a frame rate of 60 FPS
            log_message("Good Guy Position: " + str(good_guy.position))
        for bad_guy in get_tree().get_nodes_in_group("bad_guys"):
            bad_guy._physics_process(0.016) # Assuming a frame rate of 60 FPS
            log_message("Bad Guy Position: " + str(bad_guy.position))
        # Log the iteration number
        log_message("Iteration: " + str(i + 1))
