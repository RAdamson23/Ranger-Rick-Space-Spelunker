extends Panel

var dialog = ["Ranger Rick set out to be the richest man in the world, but was he satisfied?","He could find everything but did he find peace?","Directed by - Robert, AJ, Manesh and Ben",
"Created by - Robert, AJ, Manesh and Ben", "Coded by - Robert, AJ, Manesh and Ben", 
"Voice Acting by - AJ",
"We would like to thank us and ourselves","We would also like to thank you, the player","--------------------RANGER RICK: SPACE SPLUNKER--------------------"]
var dialog_index = 0
var finished = false

onready var global_vars = get_node("/root/Globals")
func _ready():
	global_vars.next_scene = "MainMenu.tscn"
	load_dialog()

func _process(delta):
	$grey_button04.visible = finished
	if Input.is_action_just_pressed("ui_accept"):
		load_dialog()

func load_dialog():
	if dialog_index < dialog.size():
		finished = false
		$IntroDialogueScript.bbcode_text = dialog[dialog_index]
		$IntroDialogueScript.percent_visible = 0
		$Tween.interpolate_property(
		$IntroDialogueScript, "percent_visible", 0,1,1, Tween.TRANS_LINEAR,Tween.EASE_IN_OUT
		)
		$Tween.start()
	else:
		changeToLevel1()
	dialog_index += 1

func changeToLevel1():
	get_tree().change_scene("res://scenes/"+global_vars.next_scene)

func _on_Tween_tween_completed(object, key):
	finished = true # Replace with function body.


