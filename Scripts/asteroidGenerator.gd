extends Node

var asteroid_scene = load("res://Scenes/asteroid.tscn")
var offset = 2000 #How far away they spawn
var slide = 100 #Variation in left or right positioning.
onready var player = get_node("/root/Level").get_node("Player")
onready var global_vars = get_node("/root/Globals")

onready var current_planet 
onready var current_planet_string 
onready var current_planet_node_path  

onready var new_position

func _physics_process(delta):
	#current_planet = global_vars.get_current_planet()
	#current_planet_string = "Planet" + String(current_planet)
	#current_planet_node_path = get_node("/root/Level").get_node("Planets").get_node(current_planet_string)
	current_planet_node_path = global_vars.get_current_planet()
	
	print(current_planet_node_path)
	
	#if current_planet_string == ("Planet1"):
	#	#TO
	#	pass
		
		
func _set_asteroid_position(asteroid):
	new_position = Vector2(current_planet_node_path.global_transform.origin.x, current_planet_node_path.global_transform.origin.y )
	
	var angle = rand_range(-PI, PI)
	new_position.x = new_position.x + (cos(angle) * offset)
	new_position.y = new_position.y - (sin(angle) * offset)
	
	angle = angle + PI/2
	var real_slide = rand_range(-slide, slide)
	new_position.x = new_position.x + (cos(angle) * real_slide)
	new_position.y = new_position.y - (sin(angle) * real_slide)
	
	#print(current_planet_node_path)
	asteroid.position = new_position

func _spawn_asteroid():
	var asteroid = asteroid_scene.instance()
	_set_asteroid_position(asteroid)
	add_child(asteroid)

func _on_SpawnTimer_timeout():
	for n in range(10):
		_spawn_asteroid()
