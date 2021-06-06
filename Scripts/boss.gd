extends Node2D

#https://ttstool.com/
#voice from here

onready var global_vars = get_node("/root/Globals")

var asteroid_scene = load("res://Scenes/asteroid_01.tscn")
var health = 5
var state = "start"


func _ready():
	global_vars.respawnLevel = "boss.tscn"
	global_vars.baseLevel = "boss.tscn"
	$MainHUD/CanvasLayer/Control/TreasureCounter.text = "Boss health: " + str(health)
	$Wizard/Sounds/Intro.play()
	yield($Wizard/Sounds/Intro, "finished")
	yield(get_tree().create_timer(1), "timeout")
	
	state = "combat"
	
	_on_Timer_Attack_timeout()
	var new_position = Vector2($Planets/Planet.global_transform.origin.x, $Planets/Planet.global_transform.origin.y )
	var angle = rand_range(-PI, PI)
	new_position.x = new_position.x + (cos(angle) * 2000)
	new_position.y = new_position.y - (sin(angle) * 2000)
	$Wizard.position = new_position
	
	$TimerAttack.start()
	$TimerTaunt.start()
	pass

#Wizard attack
func _on_Timer_Attack_timeout():
	var i = randi() % 2
	match i:
		0:
			attack_asteroids_trailing(25)
		1:
			attack_asteroids_random(2)
		_:
			attack_asteroids_random(2)
	pass

func attack_asteroids_random(left):
	for i in range(75):
		var asteroid = asteroid_scene.instance()
		var new_position = Vector2($Planets/Planet.global_transform.origin.x, $Planets/Planet.global_transform.origin.y )
		var angle = rand_range(-PI, PI)
		new_position.x = new_position.x + (cos(angle) * 2500)
		new_position.y = new_position.y - (sin(angle) * 2500)
		asteroid.position = new_position
		add_child(asteroid)
	if left > 1:
		yield(get_tree().create_timer(1), "timeout")
		attack_asteroids_random(left - 1)

func attack_asteroids_trailing(left):
	var asteroid = asteroid_scene.instance()
	var new_position = Vector2($Planets/Planet.global_transform.origin.x, $Planets/Planet.global_transform.origin.y )
	var angle = PI/2 - $Player.rotation
	new_position.x = new_position.x + (cos(angle) * 2000)
	new_position.y = new_position.y - (sin(angle) * 2000)
	asteroid.position = new_position
	add_child(asteroid)
	if left > 1:
		yield(get_tree().create_timer(0.1), "timeout")
		attack_asteroids_trailing(left - 1)

func attack_fire():
	pass

#Player attack

func player_attack():
	if state == "dead":
		return
	elif state == "start":
		health = 10
		$MainHUD/CanvasLayer/Control/TreasureCounter.text = "Boss health: " + str(health)
		$Wizard/Sounds/Intro.stop()
		$Wizard/Sounds/Intro_skip.play()
	else:
		$Wizard/Sounds/Pain.play()
	
	var new_position = Vector2($Planets/Planet.global_transform.origin.x, $Planets/Planet.global_transform.origin.y )
	var angle = rand_range(-PI, PI)
	new_position.x = new_position.x + (cos(angle) * 2000)
	new_position.y = new_position.y - (sin(angle) * 2000)
	$Wizard/Sprite.animation = "Hit"
	yield($Wizard/Sprite, "animation_finished")
	$Wizard/Sprite.animation = "Idle"
	$Wizard.position = new_position
	pass

func _on_Wizard_body_entered(body):
	if state == "dead":
		return
	if $Wizard.visible and "LaserBolt" in body.name:
		health -= 1
		$MainHUD/CanvasLayer/Control/TreasureCounter.text = "Boss health: " + str(health)
		if health <= 0:
			state = "dead"
			$TimerAttack.stop()
			$TimerTaunt.stop()
			
			#broken IDK why
			#global_vars.set_health(6)
			#for child in get_tree().get_root().get_children():
			#	if ("Asteroid" in child.name):
			#		child.queue_free()
			
			$Wizard/Sprite.animation = "Death"
			yield(get_tree().create_timer(2), "timeout")
			$Wizard/Sounds/Loss.play()
			yield($Wizard/Sounds/Loss, "finished")
			yield(get_tree().create_timer(2), "timeout")
			#TODO: end screen
			pass
		player_attack()


func _on_TimerTaunt_timeout():
	var i = randi() % 8
	match i:
		0:
			$Wizard/Sounds/Taunt_01.play()
		1:
			$Wizard/Sounds/Taunt_02.play()
		2:
			$Wizard/Sounds/Taunt_03.play()
		3:
			$Wizard/Sounds/Taunt_04.play()
		4:
			$Wizard/Sounds/Taunt_05.play()
		5:
			$Wizard/Sounds/Taunt_06.play()
		6:
			$Wizard/Sounds/Taunt_07.play()
	pass
