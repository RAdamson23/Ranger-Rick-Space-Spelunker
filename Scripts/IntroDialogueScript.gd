extends Panel

var dialog = ["In the super cluster RUST9102_HRMAEP","There lived an ambitious space cadet",
"His name was Ranger Rick", "Rick set out to loot the entire planet cluster", 
"He wanted to be the richest person in the whole universe",
"Help him in his treasure hunt","--------------------   RANGER RICK: SPACE SPLUNKER   --------------------"]
var dialog_index = 0
var finished = false

func _ready():
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
	get_tree().change_scene("res://Levels/Level_01.tscn")

func _on_Tween_tween_completed(object, key):
	finished = true # Replace with function body.


