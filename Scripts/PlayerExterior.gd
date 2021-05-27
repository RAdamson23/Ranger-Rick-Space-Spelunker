extends KinematicBody2D

export (int) var speed = 1200
export (int) var jump_speed = -1800
export (int) var gravity = 4000
onready var stamina = get_node("/root/Level/MainHUD").get_node("CanvasLayer/Control/Stamina_Bar_Script")
onready var health = get_node("/root/Level/MainHUD").get_node("CanvasLayer/Control/Health_Bar_Script")
onready var HUDAnimationPlayer = get_node("/root/Level/MainHUD/StaminaBar")
onready var global_vars = get_node("/root/Globals")

onready var playerStates = $PlayerStates
onready var player = $PlayerSprite


#playerCentricVariables
var regen_Stamina_timeout = 0.7
var regen_Stamina_rate = 0.6


export var velocity = Vector2.ZERO
var is_jumping = false
var planets: Array
var current_planet: Node
var time_delta = 0


#Attack variables
var laserPreload := preload("res://Scenes/LaserBolt.tscn")
export var can_fire = true
var shooting = false
var rate_of_fire = 0.7

func _ready():
		planets = get_node("/root/Level/Planets/").get_children()
		current_planet = planets[0]
		_get_closest_planet(current_planet)
		_start_closest_planet_timer()


func _process(delta):
	if stamina.current_stamina < stamina.max_amount && !Input.is_action_just_released("Attack") || !Input.is_action_just_released("jump") && global_vars.isDead == false:
		stamina.current_stamina += regen_Stamina_rate*delta
	if Input.is_action_pressed("Attack") and can_fire == true:
		if stamina.current_stamina > 1:
			if HUDAnimationPlayer.current_animation == "StaminaBarFlash":
				HUDAnimationPlayer.play("StaminaBarRest")
			shoot()
		else:
			HUDAnimationPlayer.play("StaminaBarFlash")

func get_input_exterior():
	velocity.x = 0
	if Input.is_action_pressed("walk_right"):
		velocity.x += speed
		playerStates.play("Run")
		player.flip_h = false
	elif Input.is_action_pressed("walk_left"):
		velocity.x -= speed
		playerStates.play("Run")
		player.flip_h = true
	elif Input.is_action_pressed("Attack") && can_fire:
		shoot()
	else:
		if !playerStates.current_animation == "Attack":
			playerStates.play("Idle")

func _physics_process(delta):
	get_input_exterior()
	time_delta += delta

	var gravity_dir = current_planet.global_transform.origin - global_transform.origin
	rotation = gravity_dir.angle() - PI/2

	velocity.y += gravity * delta
	var snap = transform.y * 128 if !is_jumping else Vector2.ZERO
	velocity = move_and_slide_with_snap(velocity.rotated(rotation), snap, -transform.y, true, 2, PI/3)
	velocity = velocity.rotated(-rotation)

	if is_on_floor():
		is_jumping = false
		if Input.is_action_just_pressed("jump"):
			is_jumping = true
			velocity.y = jump_speed

	var current_planet_index = planets.find(current_planet,0)
	#print(current_planet_index)
	global_vars.set_current_planet(current_planet_index)

func _get_closest_planet(smallest):
	var new_smallest = smallest
	var did_change = false

	if !is_jumping:
		return

	for planet in planets:
		if !new_smallest:
			new_smallest = planet

		if global_position.distance_to(planet.global_position) < global_position.distance_to(new_smallest.global_position):
			new_smallest = planet

	if new_smallest != current_planet:
		is_jumping = false
		velocity.y = 1200

	current_planet = new_smallest


func _start_closest_planet_timer():
	var timer = Timer.new()
	timer.wait_time = 0.1
	timer.connect("timeout", self, "_get_closest_planet", [current_planet])
	add_child(timer)
	timer.start()


func shoot():
	if get_global_mouse_position().x > player.global_position.x:
			playerStates.play("Attack")
			player.flip_h = false
			$TurnAxis.position.x = 1
	elif get_global_mouse_position().x < player.global_position.x:
		playerStates.play("Attack")
		player.flip_h = true
		$TurnAxis.position.x = -1

	can_fire = false
	stamina.current_stamina -= 1
	get_node("TurnAxis").rotation = get_angle_to(get_global_mouse_position())

	var laser_instance = laserPreload.instance()
	laser_instance.position = get_node("TurnAxis/CastPoint").get_global_position()
	laser_instance.rotation = get_angle_to(get_global_mouse_position())
	get_parent().add_child(laser_instance)
	yield(get_tree().create_timer(rate_of_fire),"timeout")
	can_fire = true
