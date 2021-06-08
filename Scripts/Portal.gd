extends Node2D

onready var global_vars = get_node("/root/Globals")
onready var player = get_node("/root/Level/Player")
onready var playerHealth = get_node("/root/Level/MainHUD").get_node("CanvasLayer/Control/Health_Bar_Script")
onready var HUDAnimationPlayer = get_node("/root/Level/MainHUD/HealthBar")
export var nextLevel = "CaveInterior1.tscn"
export var levelID = 0

func _ready():
	global_vars.resetHealthStaminaAndTreasureCount()

func _on_PortalHB_body_entered(body):
	print(global_vars.coinBeen1)
	if body.name == "Player":
		if global_vars.isInsidePlanet == false:
			if levelID == 1 and global_vars.coinCount1 >= 6 and not global_vars.coinBeen1:
				global_vars.set_coinBeen1(true)
				get_tree().change_scene("res://Levels/"+nextLevel)
			elif levelID == 2 and global_vars.coinCount2 >= 6 and not global_vars.coinBeen2:
				global_vars.coinBeen2 = true
				get_tree().change_scene("res://Levels/"+nextLevel)
			elif levelID == 3 and global_vars.coinCount3 >= 6 and not global_vars.coinBeen3:
				global_vars.coinBeen3 = true
				get_tree().change_scene("res://Levels/"+nextLevel)
			else:
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
