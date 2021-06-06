extends Area2D

const SPEED = 50
var direction = Vector2()
var velocity = 1


func _physics_process(delta):
	if (get_node("/root/Level").get_node("Robots").direction == 1):
		direction.x -= SPEED * delta - velocity
	elif (get_node("/root/Level").get_node("Robots").direction == -1):
		direction.x += SPEED * delta - velocity
		$AnimatedSprite.flip_h = true
	translate(direction)

	if position.x <= 100:
		queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
