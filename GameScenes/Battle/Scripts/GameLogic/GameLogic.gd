extends Node

export(NodePath) var field_path

onready var field = get_node(field_path)

signal player_captured_a_card

var custom_rules = {
	"allow_capture_your_own_cards": false
}

func _ready():
	pass

func _capture_cards(card_positioned_at, turn_data):
	# TODO change these magic costants to global constants
	assert card_positioned_at.x >= 0
	assert card_positioned_at.y >= 0
	assert card_positioned_at.x <= 2
	assert card_positioned_at.y <= 2  
	var directions_to_check = {
		"left": card_positioned_at + Vector2(-1, 0),
		"right": card_positioned_at + Vector2(1, 0), 
		"top": card_positioned_at + Vector2(0, -1),
		"bottom": card_positioned_at + Vector2(0, 1)
	}
	# remove out of field positions 
	if card_positioned_at.x == 0:
		directions_to_check.erase("left")
	if card_positioned_at.x == 2:
		directions_to_check.erase("right")
	if card_positioned_at.y == 0:
		directions_to_check.erase("top")
	if card_positioned_at.y == 2:
		directions_to_check.erase("bottom")
	# get che container of the just placed card
	var just_placed_card = field.get_container_by_vector(card_positioned_at).get_child(0)
	# for each direction that needs to be checked
	for direction in directions_to_check:
		var card_container_to_check = field.get_container_by_vector(directions_to_check[direction])
		# if there is a card in the card container
		if card_container_to_check.get_child_count() == 1:
			# get the card
			var card_on_side = card_container_to_check.get_child(0)
			# if the placed cards has bigger values (if needs to be captured)
			if _attacking_card_wins(just_placed_card, card_on_side, direction):
				if custom_rules.allow_capture_your_own_cards:
					# capture the card
					card_on_side.capture()
				else:
					# if the card to check is blue (owned by human player) and it is the player's turn
					if card_on_side.owned_by_player and turn_data["player_in_turn"] == 1:
						continue
					# if the card to check is red (owned by AI) and it is the AI's turn
					if (not card_on_side.owned_by_player) and turn_data["player_in_turn"] == 2:
						continue
					card_on_side.capture()
					emit_signal("player_captured_a_card", turn_data["player_in_turn"])
	
func _attacking_card_wins(attacking_card, defending_card, side):
	""" Checks if the first card "captures" the defending card on a given side.
	Returns true if the defending_card is captured.
	"""
	if side == "right":
		return attacking_card.get_card_attributes().right > defending_card.get_card_attributes().left
	elif side == "left":
		return attacking_card.get_card_attributes().left > defending_card.get_card_attributes().right
	elif side == "bottom":
		return attacking_card.get_card_attributes().bottom > defending_card.get_card_attributes().top
	elif side == "top":
		return attacking_card.get_card_attributes().top > defending_card.get_card_attributes().bottom


# CONNECTED SIGNALS


func _on_CardSelected_place_card(card_index, field_position):
	""" Called when the player places a card """
	_capture_cards(field_position, {"player_in_turn": 1})

func _on_Player2Cards_turn_finished(card_positioned_at):
	""" Called when the AI places a card"""
	# TODO: apply elemental effects
	# _apply_elemental_effect()
	_capture_cards(card_positioned_at, {"player_in_turn": 2})
	$SelectionPointer._change_state($SelectionPointer/State/SelectingCard, null)