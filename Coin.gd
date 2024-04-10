extends Area2D

func _on_Coin_body_entered(body):
    if body.is_in_group("good_guys"):
        # Logic for when a good guy collects the coin
        queue_free() # This removes the coin from the scene
