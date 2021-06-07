extends Area2D

onready var global_vars = get_node("/root/Globals")
onready var health = get_node("/root/Level/MainHUD").get_node("CanvasLayer/Control/Health_Bar_Script")
var planet

func _on_Coin_body_entered(body):
	print(global_vars.coinCount1)
	print(global_vars.coinCount2)
	print(global_vars.coinCount3)
	if "Player" in body.name:
		match planet:
			1:
				global_vars.coinCount1 += 1
			2:
				global_vars.coinCount2 += 1
			3:
				global_vars.coinCount3 += 1
		health.current_health+=0.4
		queue_free()
