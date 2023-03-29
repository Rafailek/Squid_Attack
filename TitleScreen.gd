extends Node2D

func _ready():
	$GUI/StartGame.grab_focus()

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
