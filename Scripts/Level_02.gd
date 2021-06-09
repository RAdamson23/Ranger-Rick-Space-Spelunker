extends Node2D

onready var global_vars = get_node("/root/Globals")
onready var Score = get_node("/root/Level/MainHUD").get_node("CanvasLayer/Control/Score")
onready var TreasureCounter = get_node("/root/Level/MainHUD").get_node("CanvasLayer/Control/TreasureCounter")

func _ready():
	global_vars.respawnLevel = "Level_02.tscn"
	TreasureCounter.set_text("Planet 1 Batteries: " + str(global_vars.coinCount1)+" / 10")
	global_vars.next_scene = "boss.tscn"
	global_vars.baseLevel = "Level_02.tscn"
	if global_vars.isInsidePlanet:
		$PlanetEnterOverlay/AnimationPlayer.play("MoveUp")
		global_vars.isInsidePlanet = false
	pass # Replace with function body.

func _process(_delta):
	match global_vars.Planet4HUDUpdater:
		1:
			TreasureCounter.set_text("Planet 1 Batteries: " + str(global_vars.coinCount1)+" / 6")
		2:
			TreasureCounter.set_text("Planet 2 Batteries: " + str(global_vars.coinCount2)+" / 6")
		3:
			TreasureCounter.set_text("Planet 3 Batteries: " + str(global_vars.coinCount3)+" / 6")
	Score.set_text("Score: " + str(global_vars.score))
