extends Node

var asteroid_scene = load("res://Scenes/Asteroid.tscn")

func _ready():
	_spawn_asteroid()

func _set_asteroid_position(asteroid):
	var rect = get_viewport().size
	var PositionOfPlayerY = (get_node("/root/MainLevel").get_node("Player").global_transform.origin.y)
	var PositionOfPlayerX = (get_node("/root/MainLevel").get_node("Player").global_transform.origin.x)
	#print(PositionOfPlayerY)
	print(PositionOfPlayerX)
	asteroid.position = Vector2(PositionOfPlayerX - 100, PositionOfPlayerY + 100 )

func _spawn_asteroid():
	var asteroid = asteroid_scene.instance()
	
	_set_asteroid_position(asteroid)
	add_child(asteroid)


	
func _on_SpawnTimer_timeout():
	_spawn_asteroid()
