extends Control

onready var global_vars = get_node("/root/Globals")

func _ready():

	$Information/Score/ScoreCount.set_text(str(global_vars.score))
	$Information/EnemiesDefeated/EnemiesDefeatedCount.set_text(str(global_vars.enemiesDefeated)+" x 5 points each")
	$Information/Deaths/DeathCount.set_text(str(global_vars.deathCount)+" x -20 points each")
	var totalscore = global_vars.scoreCalc()
	$Information/TotalScore/TotalScoreCount.set_text(str(totalscore))

	global_vars.score = totalscore
	
func _on_Next_Level_pressed():
	global_vars.next_level()
