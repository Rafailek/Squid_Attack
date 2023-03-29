extends Node2D

func _ready():
	$GUI/StartGame.grab_focus()
	
	if ScoreKeeping.P1_Points > ScoreKeeping.P2_Points:
		$GUI/Result.set_text("Blue Wins!")
		$Blue.play("BlueWins")
		$Red.play("BlueWins")
	elif ScoreKeeping.P2_Points > ScoreKeeping.P1_Points:
		$GUI/Result.set_text("Red Wins!")
		$Blue.play("RedWins")
		$Red.play("RedWins")
	else:
		$GUI/Result.set_text("It's a tie!")
		$Blue.play("RedWins")
		$Red.play("BlueWins")

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().change_scene("res://TitleScreen.tscn")
