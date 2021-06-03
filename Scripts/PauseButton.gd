extends Node


func _on_Button_pressed():
	Globals.emit_signal("pauseGame")
