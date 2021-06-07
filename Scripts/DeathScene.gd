extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var global_vars = get_node("/root/Globals")

# Called when the node enters the scene tree for the first time.
func _ready():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var my_random_number = rng.randi_range(0, 2)
	if my_random_number == 1:
		$PleaseStandBy.play()
	else:
		$CurbYourEnthusiasm.play()
	$Information/Score/ScoreCount.set_text(str(global_vars.score))
	$Information/EnemiesDefeated/EnemiesDefeatedCount.set_text(str(global_vars.enemiesDefeated)+" x 5 points each")
	#$Information/BonusesCollected/BonusesCollectedCount.set_text(str(global_vars.mainCollectable)+" x 50 points each")
	$Information/Deaths/DeathCount.set_text(str(global_vars.deathCount)+" x -20 points each")
	$Information/TotalScore/TotalScoreCount.set_text(str(global_vars.scoreCalc()))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$MovingBG/ParallaxBackground/ParallaxLayer.motion_offset.x += 0.1
	$MovingBG/ParallaxBackground/ParallaxLayer2.motion_offset.x += 0.2
	$MovingBG/ParallaxBackground/ParallaxLayer3.motion_offset.x += 0.6
	$MovingBG/ParallaxBackground/ParallaxLayer4.motion_offset.x += 0.8
	$MovingBG/ParallaxBackground/ParallaxLayer5.motion_offset.x += 1


func _on_Restart_pressed():
	if !global_vars.isInsidePlanet:
		get_tree().change_scene("res://Levels/"+global_vars.baseLevel)
	else:
		get_tree().change_scene("res://Levels/"+global_vars.respawnLevel)
	global_vars.resetHealthStaminaAndTreasureCount()

