extends Node2D

onready var global_vars = get_node("/root/Globals")

func _ready():
	pass # Replace with function body.
export var nextLevel = "CaveInterior1.tscn"

func _on_PortalHB_body_entered(body):
	if body.name == "Player":
		var filename = get_filename()
		if global_vars.isInsidePlanet == false:
			get_tree().change_scene("res://Levels/"+nextLevel)
		else:
			get_tree().change_scene("res://Levels/"+global_vars.get_baseLevel())
	pass # Replace with function body.
