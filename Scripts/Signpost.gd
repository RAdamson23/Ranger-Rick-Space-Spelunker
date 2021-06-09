extends Node2D

export var text = "Collect 6 batteries to open the portal"


func _on_Hitbox_body_entered(body):
	if body.name == "Player":
		$Container/Label.text = text
		$Container/Label.visible = true
		$AnimationPlayer.play("typewriter")
		$AnimationPlayer.queue("Rest")
	


func _on_Hitbox_body_exited(body):
	if body.name == "Player":
		$AnimationPlayer.play("reverse")
		#$Label.visible = false
