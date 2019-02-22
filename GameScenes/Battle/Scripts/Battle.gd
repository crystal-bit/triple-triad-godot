extends Control


enum {
	WIN,  # 0
	LOSE,  # 1
	DRAW  # 2
}


signal battle_ended()


func _on_Field_match_ended():
	emit_signal("battle_ended", _get_match_result())


func _get_match_result() -> int:
	if $Scores/Player1Score.value > $Scores/Player2Score.value:
		return WIN
	if $Scores/Player1Score.value < $Scores/Player2Score.value:
		return LOSE
	else:
		return DRAW