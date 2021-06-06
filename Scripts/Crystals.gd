extends Area2D
tool
onready var stamina = get_node("/root/Level/MainHUD").get_node("CanvasLayer/Control/Stamina_Bar_Script")
onready var health = get_node("/root/Level/MainHUD").get_node("CanvasLayer/Control/Health_Bar_Script")
onready var global_vars = get_node("/root/Globals")

export var mode = "Health"

func _ready():
	match mode:
		"Health":
			$Health.visible = true
			$Stamina.visible = false
			$Score.visible = false
		"Score":
			$Score.visible = true
			$Stamina.visible = false
			$Health.visible = false
		"Stamina":
			$Stamina.visible = true
			$Score.visible = false
			$Health.visible = false
	pass 

func _on_Crystal_body_entered(body):
	if body.is_in_group("Player") || body.is_in_group("Fireball"):
		match mode:
			"Health":
				health.current_health+=1.5
				$AnimationPlayer.play("Flash_Health")
			"Stamina":
				stamina.current_stamina+=2.5
				$AnimationPlayer.play("Flash_Stamina")
			"Score":
				global_vars.score+=5
				$AnimationPlayer.play("Flash_Score")
		$CollisionShape2D.call_deferred("set_disabled", true)
		$Timer.start()

func _on_Timer_timeout():
	queue_free()
