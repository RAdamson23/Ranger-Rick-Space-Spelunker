extends KinematicBody2D

onready var playerHealth = get_node("/root/Level/MainHUD").get_node("CanvasLayer/Control/Health_Bar_Script")
onready var player = get_node("/root/Level/Player")
onready var global_vars = get_node("/root/Globals")
var bullet = preload("res://Scenes/RobotFireball.tscn")

var bulletCount = 0
var timer = 0
var eye_reach = 90
var vision = 600
var movementCancelled = false
var playerKillTime = false
var rate_of_fire = 0.3

export var direction = 1 #left
export var detectsCliffs = true

var velocity = Vector2()
var speed = 100

func _ready():
	if direction == 1:
		$AnimatedSprite.flip_h = false

	$FloorChecker.position.x = $CollisionShape2D.shape.get_extents().x * direction
	$FloorChecker.enabled = detectsCliffs

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

func _physics_process(delta):
	if is_on_wall() or not $FloorChecker.is_colliding() and detectsCliffs and is_on_floor():
		direction = direction * -1
		$AnimatedSprite.flip_h = not $AnimatedSprite.flip_h
		$FloorChecker.position.x = $CollisionShape2D.shape.get_extents().x * direction

	if sees_player() and movementCancelled == false:
		$AnimatedSprite.play("run")
		velocity.y += 20
		velocity.x = speed * direction
		velocity = move_and_slide(velocity, Vector2.UP)
		
		if player.position.x < position.x:
			$AnimatedSprite.flip_h = true

	if playerKillTime == true:
		
		timer += 1
		if timer > 50:
			timer = 0
			bulletCount = 0

		if timer < 50 and bulletCount < 1:
			#var bullets = bullet.instance()
			#get_parent().add_child(bullets)
			shoot()
			#bullets.position = $Position2D.global_position
			bulletCount += 1

	if !sees_player():
		$AnimatedSprite.play("idle")

func shoot():
	var test = get_angle_to(get_global_mouse_position())
	
	if get_global_mouse_position() < player.global_position:
		$AnimatedSprite.flip_h = true
	else:
		$AnimatedSprite.flip_h = false
	$AnimatedSprite.play("shoot")
	get_node("TurnAxis").rotation = test

	var bullets = bullet.instance()
	bullets.position = get_node("TurnAxis/CastPoint").get_global_position()
	bullets.rotation = test + rotation
	get_parent().add_child(bullets)
	yield(get_tree().create_timer(rate_of_fire),"timeout")
	#can_fire = true

func die() -> void:
	speed = 0
	set_collision_mask_bit(0,false)
	$AnimatedSprite.play("die")
	$AnimatedSprite.modulate = (100)

	var t = Timer.new()
	t.set_wait_time(0.25)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")

	_on_Timer_timeout()

	t.queue_free()

func _on_Timer_timeout():
	queue_free()
	pass

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		$AnimatedSprite.play("shoot")
		movementCancelled = true
		playerKillTime = true

func _on_Area2D_body_exited(body):
	$AnimatedSprite.play("run")
	playerKillTime = false
	movementCancelled = false
