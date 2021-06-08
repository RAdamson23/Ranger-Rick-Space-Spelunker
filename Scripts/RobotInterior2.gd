extends Node

onready var global_vars = get_node("/root/Globals")
onready var Score = get_node("/root/Level/MainHUD").get_node("CanvasLayer/Control/Score")
onready var TreasureCounter = get_node("/root/Level/MainHUD").get_node("CanvasLayer/Control/TreasureCounter")
# Called when the node enters the scene tree for the first time.
func _ready():
	global_vars.respawnLevel = "RobotInterior2.tscn"
	global_vars.isInsidePlanet = true
	get_node("/root/Level/MainHUD/CanvasLayer/Control").visible = true
	yield(get_tree().create_timer(0.2),"timeout")
	$CanvasLayer/AnimationPlayer.play("MoveDown")
	pass # Replace with function body.
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	TreasureCounter.set_text("Treasure: " + str(global_vars.treasureCount)+" / 2")
	Score.set_text("Score: " + str(global_vars.score))
