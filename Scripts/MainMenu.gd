extends Control

onready var global_vars = get_node("/root/Globals")

func _ready():
	pass 

func _process(delta):
	$MovingBG/ParallaxBackground/ParallaxLayer.motion_offset.x += 0.1
	$MovingBG/ParallaxBackground/ParallaxLayer2.motion_offset.x += 0.2
	$MovingBG/ParallaxBackground/ParallaxLayer3.motion_offset.x += 0.6
	$MovingBG/ParallaxBackground/ParallaxLayer4.motion_offset.x += 0.8
	$MovingBG/ParallaxBackground/ParallaxLayer5.motion_offset.x += 1
	pass


func _on_Start_pressed():
	global_vars._ready()
	get_tree().change_scene("res://Scenes/CutScene.tscn")
	pass 


func _on_Exit_pressed():
	get_tree().quit()
	pass 
