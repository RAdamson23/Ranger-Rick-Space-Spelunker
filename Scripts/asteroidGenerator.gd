extends Node

var asteroid_scene = [ # list of all types of asteroids
	load("res://Scenes/asteroid_01.tscn"),
	load("res://Scenes/asteroid_02.tscn")
]
var offset = 2000 #How far away they spawn
var slide = 100 #Variation in left or right positioning.
onready var global_vars = get_node("/root/Globals")

var current_planet
var asteroid_type

func _physics_process(delta):
	current_planet = global_vars.get_current_planet()
	
	match current_planet.name:
		"Planet0":
			asteroid_type = 0
		"Planet1":
			asteroid_type = 0
		"Planet2":
			asteroid_type = 1
		_:
			asteroid_type = 0
	

func _set_asteroid_position(asteroid):
	var new_position = Vector2(current_planet.global_transform.origin.x, current_planet.global_transform.origin.y )
	
	var angle = rand_range(-PI, PI)
	new_position.x = new_position.x + (cos(angle) * offset)
	new_position.y = new_position.y - (sin(angle) * offset)
	
	angle = angle + PI/2
	var real_slide = rand_range(-slide, slide)
	new_position.x = new_position.x + (cos(angle) * real_slide)
	new_position.y = new_position.y - (sin(angle) * real_slide)
	
	asteroid.position = new_position

func _spawn_asteroid():
	var asteroid = asteroid_scene[asteroid_type].instance()
	_set_asteroid_position(asteroid)
	add_child(asteroid)

func _on_SpawnTimer_timeout():
	for n in range(10):
		_spawn_asteroid()
