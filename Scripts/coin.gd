extends Area2D

onready var global_vars = get_node("/root/Globals")

func _on_Coin_body_entered(body):
	if "Player" in body.name:
		global_vars.coinCount += 1
		queue_free()
