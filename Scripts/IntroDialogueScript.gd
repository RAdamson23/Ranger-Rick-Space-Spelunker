extends Panel

var dialog = ["In the super cluster RUST9102_HRMAEP"]
var dialog_index = 0
var finished = false

func _ready():
	load_dialog()

func _process(delta):
	#$grey_button04.visible = finished
	#if Input.is_action_just_pressed("ui_accept"):
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
	#else:
		#get_tree().change_scene("res://Scene/Level1.tscn")
	dialog_index += 1



func _on_Tween_tween_completed(object, key):
	finished = true # Replace with function body.
