extends Area2D

const SPEED = 50
var direction = Vector2()
var velocity = 1


func _physics_process(delta):
	direction.x -= SPEED * delta - velocity
	$AnimatedSprite.flip_h = true
	translate(direction)

	if position.x <= 1:
		queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
