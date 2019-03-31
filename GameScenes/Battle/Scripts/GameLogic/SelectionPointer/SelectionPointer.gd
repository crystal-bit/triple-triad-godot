extends TextureRect

""" SelectionPointer
This pointer handles the selection of the players cards 
that are not on the field.
Another node (FieldSelectionPointer) is responsible to handle the card
to play on the Field.
"""
# TODO: this script should be attached to the State node and not SelectionPointer

var current_state

onready var audio = $Audio

func _ready():
	# disable node processing
	$State/SelectingCard.set_process(false)
	$State/CardSelected.set_process(false)
	$State/Idle.set_process(false)
	# set current state
	current_state = $State/SelectingCard
	# init the state
	current_state.init(0)
	# start state processing
	current_state.set_process(true)


func _change_state(new_state, params):
	current_state.set_process(false)
	current_state.exit()
	current_state = new_state
	current_state.init(params)
	current_state.set_process(true)

# SIGNALS

func _on_SelectingCard_card_selected(params):
	_change_state($State/CardSelected, params)

func _on_CardSelected_return_to_card_selection(starting_index):
	_change_state($State/SelectingCard, starting_index)

func _on_CardSelected_change_to_idle_state():
	_change_state($State/Idle, null)

func _on_Player2Cards_turn_finished(param):
	_change_state($State/SelectingCard, null)