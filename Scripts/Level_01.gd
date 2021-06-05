extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var global_vars = get_node("/root/Globals")
onready var Score = get_node("/root/Level/MainHUD").get_node("CanvasLayer/Control/Score")
onready var TreasureCounter = get_node("/root/Level/MainHUD").get_node("CanvasLayer/Control/TreasureCounter")

# Called when the node enters the scene tree for the first time.
func _ready():
	TreasureCounter.set_text("Planet 1 Coins: " + str(global_vars.coinCount1)+" / 10")
	global_vars.set_baseLevel("Level_01.tscn")
	global_vars.next_scene = "Level_02.tscn"
	global_vars.isInsidePlanet = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	match global_vars.Planet4HUDUpdater:
		1:
			TreasureCounter.set_text("Planet 1 Coins: " + str(global_vars.coinCount1)+" / 6")
		2:
			TreasureCounter.set_text("Planet 2 Coins: " + str(global_vars.coinCount2)+" / 6")
		3:
			TreasureCounter.set_text("Planet 2 Coins: " + str(global_vars.coinCount3)+" / 6")
	Score.set_text("Score: " + str(global_vars.score))
