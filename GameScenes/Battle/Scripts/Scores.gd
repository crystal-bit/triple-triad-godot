extends Control


func _ready():
	pass

func _on_GameLogic_player_captured_a_card(player_id):
	if player_id == 1:
		$Player1Score.increase()
		$Player2Score.decrease()
	else:
		$Player2Score.increase()
		$Player1Score.decrease()
