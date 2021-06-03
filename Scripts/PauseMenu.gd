extends Control

onready var global_vars = get_node("/root/Globals")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Globals.connect("pauseGame", self, "pauseGame")
	$Panel/Resume.grab_focus()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	if $Panel/Resume.is_hovered():
		$Panel/Resume.grab_focus()
	if $Panel/Exit2Menu.is_hovered():
		$Panel/Exit2Menu.grab_focus()
	if $Panel/Quit.is_hovered():
		$Panel/Quit.grab_focus()
		
func _input(event):
	if event.is_action_pressed("ui_cancel") || global_vars.pause_mode: 
		$Panel/Resume.grab_focus()
		get_tree().paused = !get_tree().paused
		visible = !visible


func _on_Resume_pressed():
	get_tree().paused = !get_tree().paused
	visible = !visible



func _on_Exit2Menu_pressed():
	get_tree().paused = !get_tree().paused
	get_tree().change_scene("res://Scenes/TitleScreen.tscn")

func _on_Quit_pressed():
	get_tree().paused = !get_tree().paused
	get_tree().quit()


func _on_SFX_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), linear2db(value))
	pass # Replace with function body.


func _on_Music_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear2db(value))
	pass # Replace with function body.
