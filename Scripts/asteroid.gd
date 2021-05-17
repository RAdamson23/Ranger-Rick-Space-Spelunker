extends KinematicBody2D

export (int) var speed = 50
var velocity = Vector2.ZERO

func _ready():
	var gravity_dir = _get_closest_planet().global_transform.origin - global_transform.origin
	rotation = gravity_dir.angle() - PI/2

func _physics_process(delta):
	velocity.y += speed
	move_and_slide(velocity.rotated(rotation))

func _on_Area2D_body_entered(body):
	if body.name == "PlanetStaticBody2D":
		queue_free()
	if body.name == "Player":
		pass
		#TODO: kill player???

func _get_closest_planet():
	var planets = get_node("/root/Level/Planets").get_children()
	var smallest_planet = planets[0]
	
	for planet in planets:
		if global_position.distance_to(planet.global_position) < global_position.distance_to(smallest_planet.global_position):
			smallest_planet = planet
			
	return smallest_planet
