extends Node2D

onready var global_vars = get_node("/root/Globals")
onready var Score = get_node("/root/Level/MainHUD").get_node("CanvasLayer/Control/Score")
onready var TreasureCounter = get_node("/root/Level/MainHUD").get_node("CanvasLayer/Control/TreasureCounter")
onready var eDefeated = get_node("/root/Level/MainHUD").get_node("CanvasLayer/Control/EnemiesDefeated")
# Called when the node enters the scene tree for the first time.
func _ready():
	#global_vars._ready()
	global_vars.isInsidePlanet = true
	get_node("/root/Level/MainHUD/CanvasLayer/Control").visible = true
	#global_vars.current_scene = "res://Scenes/CaveLevel2.tscn"
	#global_vars.next_scene = "res://Scenes/OutroScene.tscn"
	pass # Replace with function body.
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	TreasureCounter.set_text("Treasure: " + str(global_vars.treasureCount)+" / 2")
	Score.set_text("Score: " + str(global_vars.score))
	#mPos.set_text("Mouse Position: " + str(get_viewport().get_mouse_position()))
	#eDefeated.set_text("Enemies Defeated: " + str(global_vars.enemiesDefeated))
