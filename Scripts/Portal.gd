extends Area2D

func _ready():
	pass # Replace with function body.

func _on_Portal_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene("res://Levels/CaveInterior1.tscn")
