extends Node

signal new_card_pointed # when the cursor moves and points to a new card
signal card_selected  # when the user press the accept button to play the card on the field

export(int, 0, 4) var selected_card_index = 0  # index, strarting from the top
export(NodePath) var cards_container_node_path

onready var selection_pointer = get_parent().get_parent()
var cards_container

# do not use _ready() because it's called even if you use set_process(false) from the parent node,
# breaking the State pattern
func init(starting_index):
	# TODO: delete this line and update the code to update selection_pointer
	# to the nearest card from the last selected one
	selected_card_index = 0
	
	cards_container = get_node(cards_container_node_path)
	if starting_index != null:
		selected_card_index = starting_index
	_point_at_card(_get_card_at_index(selected_card_index))
	selection_pointer.modulate.a = 1

func _process(delta):
	# store current selected card index
	var old_card_index = selected_card_index
	# get the number of remaining cards
	var remaining_cards = cards_container.get_card_count()
	if Input.is_action_just_pressed("ui_up"):
		# clamp the value
		selected_card_index = max(0, selected_card_index - 1)
		_point_at_card(_get_card_at_index(selected_card_index))
	elif Input.is_action_just_pressed("ui_down"):
		# clamp the value
		selected_card_index = min(remaining_cards - 1, selected_card_index + 1)
		_point_at_card(_get_card_at_index(selected_card_index))
	# if the player selected a new card
	if old_card_index != selected_card_index:
		# emit a signal
		emit_signal("new_card_pointed", selected_card_index)
		selection_pointer.audio.get_node("CursorMove").play()
	if Input.is_action_just_pressed("ui_accept"):
		emit_signal("card_selected", {"card_index": selected_card_index})

func exit():
	pass

func _point_at_card(card):
	# updates the pointer position to the card center (using an hardcoded offset for now)
	selection_pointer.rect_position.y = card.rect_position.y + 150

func _get_card_at_index(card_index):
	return cards_container.get_card_container_at(card_index)