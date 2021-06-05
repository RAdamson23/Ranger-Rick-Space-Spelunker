extends Node2D

onready var global_vars = get_node("/root/Globals")
onready var player = get_node("/root/Level/Player")
onready var playerHealth = get_node("/root/Level/MainHUD").get_node("CanvasLayer/Control/Health_Bar_Script")
onready var HUDAnimationPlayer = get_node("/root/Level/MainHUD/HealthBar")
export var nextLevel = "CaveInterior1.tscn"


func _ready():
	#$AnimatedSprite.play("Closed")
	pass # Replace with function body.

func _on_PortalHB_body_entered(body):
	if body.name == "Player":
		var filename = get_filename()
		if global_vars.isInsidePlanet == false and global_vars.coinCount >= 10:
			global_vars.coinCount -= 10
			get_tree().change_scene("res://Levels/"+nextLevel)
		elif global_vars.isInsidePlanet:
			HUDAnimationPlayer.play("PieCounterTextFlash")
			yield(get_tree().create_timer(1.5),"timeout")
			HUDAnimationPlayer.play("Rest")
		elif global_vars.planetsCompleted == 2 && global_vars.treasureCount == 2:
			get_tree().change_scene("res://Scenes/LevelComplete.tscn")
		elif global_vars.treasureCount == 2:
			global_vars.planetsCompleted+=1
			playerHealth.canBeDamaged = false
			player.get_node("PlayerEffects").play("State_Visible")
			player.get_node("PlayerStates").play("Idle")
			player.ispaused = true
			yield(get_tree().create_timer(1.5),"timeout")
			player.get_node("PlayerEffects").play("State_Rest")
			player.ispaused = false
			playerHealth.canBeDamaged = true
			#player.get_node("Hitbox/CollisionShape2D").call_deferred("set_disabled", false)
			get_tree().change_scene("res://Levels/"+global_vars.get_baseLevel())
		else:
			HUDAnimationPlayer.play("PieCounterTextFlash")
			yield(get_tree().create_timer(1.5),"timeout")
			HUDAnimationPlayer.play("Rest")
	pass # Replace with function body.
