extends Node

signal return_to_card_selection
signal place_card
signal change_to_idle_state

onready var selection_pointer = get_parent().get_parent()

# Node dependencies
export(NodePath) var field_selection_pointer_path
export(NodePath) var player_cards_path
export(NodePath) var field_path

onready var field_selection_pointer = get_node(field_selection_pointer_path)
onready var player_cards = get_node(player_cards_path)
onready var field = get_node(field_path)

var selected_card_index
var selected_position

func init(params):
	selected_card_index = params.card_index
	selection_pointer.modulate.a = 0.5
	field_selection_pointer.show()
	selected_position = Vector2(1, 1)  # the center slot
	# play selected sound
	selection_pointer.audio.get_node("CursorMove").play()

func exit():
	field_selection_pointer.hide()
	
func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		emit_signal("return_to_card_selection", selected_card_index)
		selection_pointer.audio.get_node("Cancel").play()
	# store the position to a variable to compare it afterwards
	var old_selected_position = selected_position
	if Input.is_action_just_pressed("ui_up"):
		selected_position.y = max(0, selected_position.y - 1)
	elif Input.is_action_just_pressed("ui_down"):
		selected_position.y = min(2, selected_position.y + 1)
	elif Input.is_action_just_pressed("ui_left"):
		selected_position.x = max(0, selected_position.x - 1)
	elif Input.is_action_just_pressed("ui_right"):
		selected_position.x = min(2, selected_position.x + 1)
	# if the cursor moved
	if selected_position != old_selected_position:
		selection_pointer.audio.get_node("CursorMove").play()
	
	# update field_selection_pointer position
	field_selection_pointer.rect_position = (selected_position*256) + Vector2(400, 192)
	if Input.is_action_just_pressed("ui_accept"):
		if field.is_position_empty(selected_position):
			selection_pointer.audio.get_node("CardMove").play()
			emit_signal("place_card", selected_card_index, selected_position)
			emit_signal("change_to_idle_state")
		else:
			selection_pointer.audio.get_node("Invalid").play()
		
