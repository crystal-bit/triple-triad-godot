extends Control


enum {
	WIN,  # 0
	LOSE,  # 1
	DRAW  # 2
}


signal battle_ended


var rules setget set_rules  # Game node updates this variable


func set_rules(value):
	rules = value
	print(rules)

	if rules.get("Open") == false:
		# Update AI cards texture to show the back side of the card
		for card_container in $Player2Cards.get_children():
			if card_container is Control:
				var card = card_container.get_child(0)
				print(card.covered)
				card.covered = true

func _on_Field_match_ended():
	var match_result = _get_match_result()
	# update global values
	if match_result == WIN:
		GlobalState.matches_stats["won"] += 1
	elif match_result == LOSE:
		GlobalState.matches_stats["lost"] += 1
	elif match_result == DRAW:
		GlobalState.matches_stats["drawn"] += 1
	emit_signal("battle_ended", match_result)


func _get_match_result() -> int:
	if $Scores/Player1Score.value > $Scores/Player2Score.value:
		return WIN
	if $Scores/Player1Score.value < $Scores/Player2Score.value:
		return LOSE
	else:
		return DRAW
