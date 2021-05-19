extends KinematicBody2D

export (int) var speed = 1200
export (int) var jump_speed = -1800
export (int) var gravity = 4000

var isInPlanet = false
onready var global_vars = get_node("/root/Globals")
onready var stamina = get_node("/root/Level/MainHUD").get_node("CanvasLayer/Control/Stamina_Bar_Script")
onready var health = get_node("/root/Level/MainHUD").get_node("CanvasLayer/Control/Health_Bar_Script")
onready var HUDAnimationPlayer = get_node("/root/Level/MainHUD/StaminaBar")

onready var playerStates = $PlayerStates
onready var player = $PlayerSprite



#playerCentricVariables
onready var ispaused = false
onready var motion = Vector2()
const ACCELERATION = 80
var knockback = 20
var MAX_SPEED = 280
const GRAVITY = 25
const JUMP_HEIGHT = -650
var spriteFlip = false
var move_direction
const UP = Vector2(0, -1)
var dub_jumps = 0
var can_jump = false
var max_num_dub_jumps = 1
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
	if global_vars.get_isInPlanet() == false:
		planets = get_node("/root/Level/Planets/").get_children()
		current_planet = planets[0]
		_get_closest_planet(current_planet)
		_start_closest_planet_timer()
		print(velocity)

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

func get_input_interior():
	if !global_vars.isDead && ispaused == false && playerStates.current_animation != "Attack":
		motion.y += GRAVITY
		var friction = false
		if Input.is_action_pressed("walk_right"):
			player.flip_h = false #flip sprite to face direction
			motion.x = min(motion.x+ACCELERATION, MAX_SPEED)
			playerStates.play("Run")
		elif Input.is_action_pressed("walk_left"):
			player.flip_h = true #flip sprite to face direction
			motion.x = max(motion.x-ACCELERATION, -MAX_SPEED)
			playerStates.play("Run")
		else:
			friction = true
			playerStates.play("Idle")

		if Input.is_action_just_pressed("jump"):
			is_jumping = true
			if can_jump:
				motion.y = JUMP_HEIGHT	
			elif dub_jumps > 0  && stamina.current_stamina > 1:
				motion.y = JUMP_HEIGHT
				dub_jumps -= 1
				stamina.current_stamina-=0.8

		if is_on_floor():
			can_jump = true
			dub_jumps = max_num_dub_jumps
			if friction == true:
				motion.x = lerp(motion.x,0,0.2)
		else:

			can_jump = false
			if friction == true:
				motion.x = lerp(motion.x,0,0.05)
		if is_on_wall() && stamina.current_stamina > 1 && (Input.is_action_pressed("walk_right") || Input.is_action_pressed("walk_left")):
			if stamina.current_stamina > 0.5:
				dub_jumps = max_num_dub_jumps
				if Input.is_action_just_pressed("jump"):
					stamina.current_stamina -= 0.5
		var snap = Vector2.DOWN * 32 if !is_jumping else Vector2.ZERO
		motion = move_and_slide_with_snap(motion,snap,UP)

func _physics_process(delta):
	if global_vars.get_isInPlanet() == false && !planets.count(0):
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
	else:
		get_input_interior()


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
#
