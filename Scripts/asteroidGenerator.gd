extends Node

var asteroid_scene = load("res://Scenes/Asteroid.tscn")
var offset = 500
var slide = 500
onready var player = get_node("/root/Level").get_node("Player")

func _set_asteroid_position(asteroid):
	var new_position = Vector2(player.global_transform.origin.x, player.global_transform.origin.y )
	var angle = PI/2 - player.rotation
	new_position.x = new_position.x + (cos(angle) * offset)
	new_position.y = new_position.y - (sin(angle) * offset)
	
	angle = angle + PI/2
	var real_slide = rand_range(-slide, slide)
	new_position.x = new_position.x + (cos(angle) * real_slide)
	new_position.y = new_position.y - (sin(angle) * real_slide)
	
	asteroid.position = new_position

func _spawn_asteroid():
	var asteroid = asteroid_scene.instance()
	
	_set_asteroid_position(asteroid)
	add_child(asteroid)

func _on_SpawnTimer_timeout():
	_spawn_asteroid()
