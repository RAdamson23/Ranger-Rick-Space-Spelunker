extends RigidBody2D

onready var playerHealth = get_node("/root/Level/MainHUD").get_node("CanvasLayer/Control/Health_Bar_Script")
export var speed = 800
func _ready():
	$Whoosh.play()
	apply_impulse(Vector2(),Vector2(speed,0).rotated(rotation))

func Explode():
	$Timer.start()
	$CollisionShape2D.call_deferred("set_disabled", true)
	$Laser.play("Explode")

func _on_VisibilityNotifier2D_screen_exited():
	$Timer.start(1)

func _on_Timer_timeout():
	queue_free()
	pass # Replace with function body.

func _on_Fireball_body_entered(body):
	if body.is_in_group("Player"):
		playerHealth.current_health -= 0.7
		Explode()
	if !body.is_in_group("Enemies"):
		Explode()
