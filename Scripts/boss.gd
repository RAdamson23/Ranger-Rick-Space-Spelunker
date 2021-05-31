extends Node2D

var asteroid_scene = load("res://Scenes/asteroid_01.tscn")
var planet
var player
var wizard

var health = 10
var week = false

#stages
# asterord doge
# shot the boss
# repeate

func _ready():
	planet = $Planets/Planet
	player = $Player
	wizard = $Wizard
	wizard.visible = false
	pass

func attack_asteroids_random(left):
	for i in range(50):
		var asteroid = asteroid_scene.instance()
		var new_position = Vector2(planet.global_transform.origin.x, planet.global_transform.origin.y )
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
	var new_position = Vector2(planet.global_transform.origin.x, planet.global_transform.origin.y )
	var angle = PI/2 - player.rotation
	new_position.x = new_position.x + (cos(angle) * 2000)
	new_position.y = new_position.y - (sin(angle) * 2000)
	asteroid.position = new_position
	add_child(asteroid)
	if left > 1:
		yield(get_tree().create_timer(0.1), "timeout")
		attack_asteroids_trailing(left - 1)

func player_attack():
	wizard.visible = true
	week = true
	
	yield(get_tree().create_timer(8), "timeout")
	week = false
	wizard.visible = false
	pass

func _on_Wizard_body_entered(body):
	if week and "LaserBolt" in body.name:
		print("Hit")
		#TODO: add dammange to boss

func _on_Timer_timeout():
	match randi() % 3:
		0:
			attack_asteroids_trailing(90)
		1:
			attack_asteroids_random(9)
		2:
			player_attack()
		_:
			attack_asteroids_random(9)
	pass



