extends Area2D

func _ready():
	pass # Replace with function body.
export var nextLevel = "CaveInterior1.tscn"
func _on_Portal_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene("res://Levels/"+nextLevel)
