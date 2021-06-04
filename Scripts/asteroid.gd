extends Node2D

var damage = 1
export (int) var speed = 10
var velocity = Vector2.ZERO
onready var global_vars = get_node("/root/Globals")
onready var playerHealth = get_node("/root/Level/MainHUD").get_node("CanvasLayer/Control/Health_Bar_Script")

func _ready():
	#var gravity_dir = _get_closest_planet().global_transform.origin - global_transform.origin
	var gravity_dir = global_vars.get_current_planet().global_transform.origin - global_transform.origin
	rotation = gravity_dir.angle() - PI/2
	velocity.y += speed

func _physics_process(_delta):
	translate(velocity.rotated(rotation))

func _on_Area2D_body_entered(body):
	if body.name == "PlanetStaticBody2D":
		queue_free()
	if body.name == "Player":
		playerHealth.current_health -= damage
		pass
		#TODO: kill player???

func _get_closest_planet():
	var planets = get_node("/root/Level/Planets").get_children()
	var smallest_planet = planets[0]
	
	for planet in planets:
		if global_position.distance_to(planet.global_position) < global_position.distance_to(smallest_planet.global_position):
			smallest_planet = planet
			
	return smallest_planet
