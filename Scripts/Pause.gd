extends Control

var notPaused = true

func _ready():
	Globals.connect("pauseGame", self, "pauseGame")

func _process(_delta):
	if Input.is_action_just_pressed("pause"):
		pauseGame()
		
func pauseGame():
	if notPaused:
		get_tree().paused = true
		notPaused = false
		visible = true
	else:
		get_tree().paused = false
		notPaused = true
		visible = false

func _on_HSlider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear2db(value))


func _on_HSlider2_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), linear2db(value))

