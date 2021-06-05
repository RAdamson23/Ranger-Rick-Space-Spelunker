extends Node

var coin_scenes = load("res://Scenes/coin.tscn");

var offset = 1250 #How far away they spawn
onready var global_vars = get_node("/root/Globals")

func _set_coin_position(asteroid):
	var current_planet = global_vars.get_current_planet()
	var new_position = Vector2(current_planet.global_transform.origin.x, current_planet.global_transform.origin.y )
	
	var angle = rand_range(-PI, PI)
	new_position.x = new_position.x + (cos(angle) * offset)
	new_position.y = new_position.y - (sin(angle) * offset)
	
	asteroid.position = new_position

func _spawn_coin():
	var coin = coin_scenes.instance()
	_set_coin_position(coin)
	coin.planet = global_vars.get_current_planet().name.substr(global_vars.get_current_planet().name.length() - 1, 1).to_int() + 1
	global_vars.Planet4HUDUpdater = coin.planet
	add_child(coin)

func _on_Coins_timeout():
	_spawn_coin()
