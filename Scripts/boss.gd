extends Node2D

var asteroid_scene = load("res://Scenes/asteroid_01.tscn")
var health = 5

func _ready():
	_on_Timer_Attack_timeout()
	var new_position = Vector2($Planets/Planet.global_transform.origin.x, $Planets/Planet.global_transform.origin.y )
	var angle = rand_range(-PI, PI)
	new_position.x = new_position.x + (cos(angle) * 2000)
	new_position.y = new_position.y - (sin(angle) * 2000)
	$Wizard.position = new_position
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
	var new_position = Vector2($Planets/Planet.global_transform.origin.x, $Planets/Planet.global_transform.origin.y )
	var angle = rand_range(-PI, PI)
	new_position.x = new_position.x + (cos(angle) * 2000)
	new_position.y = new_position.y - (sin(angle) * 2000)
	$Wizard/Sprite.animation = "Hit"
	$Wizard/Sounds/Hit.play()
	yield($Wizard/Sprite, "animation_finished")
	$Wizard/Sprite.animation = "Idle"
	$Wizard.position = new_position
	pass

func _on_Wizard_body_entered(body):
	if $Wizard.visible and "LaserBolt" in body.name:
		health -= 1
		if health >= 0:
			#TODO: go to next faze
			pass
		player_attack()
