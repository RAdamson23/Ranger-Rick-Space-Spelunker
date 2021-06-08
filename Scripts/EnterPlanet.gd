extends CanvasLayer
onready var global_vars = get_node("/root/Globals")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var move_to = Vector2.RIGHT * 0
export var speed = 2.0
var IDLE_DURATION = 2
# Called when the node enters the scene tree for the first time.
func _ready():
	$TopText/Label.text = "-------Entering Planet " + str(global_vars.Planet4HUDUpdater) +"-------"
	$BOTTOMTEXT/Label.text = "Planet "+ str(global_vars.Planet4HUDUpdater) +" completed! " + "\nEnemies Defeated: " + str(global_vars.enemiesDefeated) + "\nScore: " + str(global_vars.score) + "\nDeath Count: " + str(global_vars.deathCount)
	#_init_tween()
	pass # Replace with function body.

var follow = Vector2.ZERO
	
	
#func _init_tween():
#	var duration = move_to.length() / float(speed * 64)
#	tween.interpolate_property(self,"follow",Vector2.ZERO,move_to,duration,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT,IDLE_DURATION)
#	tween.interpolate_property(self,"follow",move_to,Vector2.ZERO,duration,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT, duration+IDLE_DURATION*2)
#	tween.start()
#
#func _physics_process(_delta):
#	$ColorRect.position = $ColorRect.position.linear_interpolate(follow,0.075)
