extends Node2D

func _ready():
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
