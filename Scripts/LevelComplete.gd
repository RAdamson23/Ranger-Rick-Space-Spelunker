extends Control

onready var global_vars = get_node("/root/Globals")

func _ready():

	$Information/Score/ScoreCount.set_text(str(global_vars.score))
	$Information/EnemiesDefeated/EnemiesDefeatedCount.set_text(str(global_vars.enemiesDefeated)+" x 5 points each")
	$Information/Deaths/DeathCount.set_text(str(global_vars.deathCount)+" x -20 points each")
	var totalscore = global_vars.scoreCalc()
	$Information/TotalScore/TotalScoreCount.set_text(str(totalscore))

	global_vars.score = totalscore

func _process(delta):
	$MovingBG/ParallaxBackground/ParallaxLayer.motion_offset.x += 0.1
	$MovingBG/ParallaxBackground/ParallaxLayer2.motion_offset.x += 0.2
	$MovingBG/ParallaxBackground/ParallaxLayer3.motion_offset.x += 0.6
	$MovingBG/ParallaxBackground/ParallaxLayer4.motion_offset.x += 0.8
	$MovingBG/ParallaxBackground/ParallaxLayer5.motion_offset.x += 1

func _on_Next_Level_pressed():
	global_vars.coinBeen1 = false
	global_vars.coinCount1 = 0
	global_vars.coinBeen2 = false
	global_vars.coinCount2 = 0
	global_vars.coinBeen3 = false
	global_vars.coinCount3 = 0
	global_vars.planetsCompleted = 0
	get_tree().change_scene("res://Levels/"+global_vars.next_scene)
	
