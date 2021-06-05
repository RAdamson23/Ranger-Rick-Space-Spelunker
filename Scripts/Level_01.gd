extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var global_vars = get_node("/root/Globals")

# Called when the node enters the scene tree for the first time.
func _ready():
	global_vars.set_baseLevel("Level_01.tscn")
	global_vars.next_scene = "Level_02.tscn"
	global_vars.isInsidePlanet = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
