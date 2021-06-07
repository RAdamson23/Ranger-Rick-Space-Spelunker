extends KinematicBody2D

onready var playerHealth = get_node("/root/Level/MainHUD").get_node("CanvasLayer/Control/Health_Bar_Script")
onready var player = get_node("/root/Level/Player")
onready var global_vars = get_node("/root/Globals")

var velocity = Vector2(0,0)
const GRAVITY = 20
const SPEED = 280
const FLOOR = Vector2(0,-1)
var react_time = 200
var dir = 0
var next_dir = 0
var next_dir_time = 0
var next_jump_time = -1
var health = 2
const JUMP_HEIGHT = -550
var is_dead = false
export var damage = 2
var isHit = false
var currentAnimation = "idle"
var eye_reach = 90
var direction = 1
var vision = 600
var isRunning = 0
var is_moving_left = false
var firstrun = true
var playerDetectorExited = true
var hasSeenPlayer = false
var rateOfFire = 1.0
var can_fire = true
var stop = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.play("idle")
	pass # Replace with function body.

func sees_player():
	var eye_center = get_global_position()
	var eye_top = eye_center + Vector2(0,-eye_reach)
	var eye_left = eye_center + Vector2(-eye_reach,0)
	var eye_right = eye_center + Vector2(eye_reach,0)

	var player_pos = player.get_global_position()
	var player_extents = player.get_node("CollisionShape2D").shape.extents - Vector2(1,1)
	var top_left = player_pos + Vector2(-player_extents.x, -player_extents.y)
	var top_right = player_pos + Vector2(player_extents.x, -player_extents.y)
	var bottom_left = player_pos + Vector2(-player_extents.x, player_extents.y)
	var bottom_right = player_pos + Vector2(player_extents.x, player_extents.y)

	var space_state = get_world_2d().direct_space_state

	for eye in [eye_center,eye_top,eye_left,eye_right]:
		for corner in [top_left,top_right,bottom_left,bottom_right]:
			if (corner-eye).length() > vision:
				continue
			var collision = space_state.intersect_ray(eye,corner,[],1)
			if collision and collision.collider.name == "Player":
				return true
	return false

func switchPos():
	$TurnAxis/CastPoint.position.x *= -1
	$RayCast2D.position.x *= -1
	$PlayerDetector/CollisionShape2D.position.x *= -1
	$Hitbox/CollisionShape2D.position.x *= -1
	$Stop/CollisionShape2D.position.x *= -1

func _process(delta):
	if !is_dead && sees_player() && !stop:
		hasSeenPlayer = true
		attack()
		if isHit:
			return
		if currentAnimation == "run":
			$AnimatedSprite.play("run")
			currentAnimation = "run"
		if player.position.x < position.x:
			set_dir(-1)
			if is_moving_left == false:
				is_moving_left = true
			$AnimatedSprite.play("run")
			currentAnimation = "run"
			if direction != -1:
				switchPos()
				$AnimatedSprite.flip_h = true
				direction *= -1
		elif player.position.x > position.x:
			set_dir(1)
			if is_moving_left == true:
				is_moving_left = false
				$AnimatedSprite.flip_h = false
			$AnimatedSprite.play("run")
			currentAnimation = "run"
			if direction != 1:
				switchPos()
				direction *= -1
		else:
			set_dir(0)
		if OS.get_ticks_msec() > next_dir_time:
			dir = next_dir
		if OS.get_ticks_msec() > next_jump_time  && next_jump_time != -1 && is_on_floor():
			if player.position.y < position.y - 64 and sees_player():
				velocity.y = JUMP_HEIGHT
			next_jump_time = -1
		velocity.x = dir * SPEED
		if player.position.y < position.y - 64 and next_jump_time == -1 and sees_player():
			next_jump_time = OS.get_ticks_msec() + react_time
		velocity.y += GRAVITY
		velocity = move_and_slide(velocity,FLOOR)
		pass
	elif stop && !is_dead:
		velocity.x = 0
		velocity.y += GRAVITY
		velocity = move_and_slide(velocity,FLOOR)
		$AnimatedSprite.play("shoot")
		attack()
	elif !is_dead && hasSeenPlayer:
		movecharacter()
	elif !is_dead:
		$AnimatedSprite.play("idle")
		currentAnimation = "idle"
		velocity.x = 0
		velocity.y += GRAVITY
		velocity = move_and_slide(velocity,FLOOR)

func movecharacter():
	if firstrun:
		if currentAnimation == "run":
			$AnimatedSprite.play("run")
		velocity.x = dir * SPEED
		velocity.y += GRAVITY
		velocity = move_and_slide(velocity,FLOOR)
		if is_on_wall() || !$RayCast2D.is_colliding():
			firstrun = false
	else:
		if currentAnimation == "run":  
			$AnimatedSprite.play("run")
		if is_on_wall():
			is_moving_left = !is_moving_left
			$AnimatedSprite.flip_h = is_moving_left	
			direction = direction * -1
			switchPos()
		if !$RayCast2D.is_colliding():
			is_moving_left = !is_moving_left
			$AnimatedSprite.flip_h = is_moving_left			
			direction = direction * -1
			switchPos()
		velocity.x = SPEED * direction
		velocity.y += GRAVITY
		velocity = move_and_slide(velocity,FLOOR)

func hit():
	$AttackDetector.monitoring = true

func end_of_hit():
	$AttackDetector.monitoring = false

func start_run():
	$AnimatedSprite.play("run")
	currentAnimation = "run"

func _on_Timer_timeout():
	queue_free()

func set_dir(target_dir):
	if next_dir != target_dir:
		next_dir = target_dir
		next_dir_time = OS.get_ticks_msec() + react_time

func onHit():
	if !hasSeenPlayer:
			hasSeenPlayer = true
			firstrun = false
	$Hit.play()
	isHit = true
	health-=1
	velocity.x = 0
	velocity = move_and_slide(velocity,Vector2.UP)
	$AnimatedSprite.play("run")
	yield(get_tree().create_timer(0.25),"timeout")
	isHit = false

func dead():
	$Death.play()
	is_dead = true
	global_vars.enemiesDefeated+=1
	velocity = Vector2(0,0)
	$AnimatedSprite.play("die")
	currentAnimation = "die"
	$CollisionShape2D.call_deferred("set_disabled", true)
	$PlayerDetector/CollisionShape2D.call_deferred("set_disabled", true)
	$Hitbox/CollisionShape2D.call_deferred("set_disabled", true)
	velocity.x = 0
	while !is_on_floor():
		velocity.y+=GRAVITY
		move_and_slide(velocity,FLOOR)
	$Timer.start()

func _on_Hitbox_body_entered(body):
	if body.is_in_group("Fireball") || body.is_in_group("FallingSpikes"):
		if health > 0:
			onHit()
		else:
			dead()
func attack():
	velocity.x = 0
	#$Attack.play()
	if can_fire:
		
		shoot()

func _on_PlayerDetector_body_entered(body):
	if body.name == "Player" && sees_player():
		playerDetectorExited = false
		attack()

func _on_AttackDetector_body_entered(body):
	if body.is_in_group("Player"):
		playerHealth.current_health-=damage
	pass


func _on_PlayerDetector_body_exited(body):
	playerDetectorExited=true
	pass # Replace with function body.
	
func shoot():
	var test = get_angle_to(player.global_position)
	if stop:
		$AnimatedSprite.play("shoot")
	else:
		$AnimatedSprite.play("runShoot")
	can_fire = false
	var m_rotation = test
	m_rotation = clamp(m_rotation, 260, 90)
	get_node("TurnAxis").rotation = m_rotation
	var laserPreload := preload("res://Scenes/RobotLaser.tscn")
	var laser_instance = laserPreload.instance()
	laser_instance.position = get_node("TurnAxis/CastPoint").get_global_position()
	laser_instance.rotation = test+rotation
	
	get_parent().add_child(laser_instance)
	yield(get_tree().create_timer(rateOfFire),"timeout")
	can_fire = true


func _on_Stop_body_entered(body):
	if body.is_in_group("Player"):
		stop = true
	pass # Replace with function body.


func _on_Stop_body_exited(body):
	if body.is_in_group("Player"):
		stop = false
	pass # Replace with function body.
