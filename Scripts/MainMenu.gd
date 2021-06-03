extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var global_vars = get_node("/root/Globals")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$MovingBG/ParallaxBackground/ParallaxLayer.motion_offset.x += 0.1
	$MovingBG/ParallaxBackground/ParallaxLayer2.motion_offset.x += 0.2
	$MovingBG/ParallaxBackground/ParallaxLayer3.motion_offset.x += 0.6
	$MovingBG/ParallaxBackground/ParallaxLayer4.motion_offset.x += 0.8
	$MovingBG/ParallaxBackground/ParallaxLayer5.motion_offset.x += 1
	pass


func _on_Start_pressed():
	global_vars._ready()
	get_tree().change_scene("res://Levels/Level_01.tscn")
	pass # Replace with function body.


func _on_Exit_pressed():
	get_tree().quit()
	pass # Replace with function body.
