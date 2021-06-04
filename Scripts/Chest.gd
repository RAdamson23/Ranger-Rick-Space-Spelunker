extends Area2D

onready var global_vars = get_node("/root/Globals")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_Hitbox_body_entered(body):
	if body.name == "Player":
		global_vars.treasureCount+=1
		$CollisionShape2D.call_deferred("set_disabled", true)
		$Hitbox/CollisionShape2D.call_deferred("set_disabled",true)
		$AnimatedSprite.play("Empty")
