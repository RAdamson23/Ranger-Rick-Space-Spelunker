extends Node2D

onready var health = get_node("/root/Level/MainHUD").get_node("CanvasLayer/Control/Health_Bar_Script")
export var damage = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _on_Spike_body_entered(body):
	if body.name == "Player":
		health.current_health-=damage
	pass		
		
