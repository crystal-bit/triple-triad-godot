extends VBoxContainer

""" This script handles the AI for the Player2 """

# node dependencies
export(NodePath) var field_path

onready var field = get_node(field_path)

signal turn_finished

var selected_card_index

func _ready():
	randomize()
	set_process(false)

func enable():
	""" Enables the AI processing """
	set_process(true)
	set_current_selected_card(0)

func _process(delta):
	set_process(false)  # this NEEDS to be called before the yield
	# wait
	yield(get_tree().create_timer(1), "timeout")
	if field.cards_played < 9:
		# get card container
		var card_container = get_random_card_container()
		# flip card
		card_container.get_child(0).set_covered(false)
		# get a random position to play the card
		var rand_position = field.get_random_empty_container()
		# play the card
		field.add_card_at_position(card_container, rand_position)
		# play sound
		get_parent().get_node("GameLogic/SelectionPointer/Audio/CardMove").play()
		# finish turn
		emit_signal("turn_finished", rand_position)
	
func get_card_container_at(index):
	""" Get a Card node given an integer index
	"""
	assert index <= get_card_count() - 1
	var card_container = get_child(index)
	return card_container

func get_card_count():
	return get_child_count() - 1  # 1 node is the Tween node
	
func set_current_selected_card(index):
	assert index <= get_card_count() - 1
	var selected_card = null
	# if there is a selected card
	if selected_card_index != null:
		selected_card = get_child(selected_card_index).get_child(0)
		move_right(selected_card, 50)
	
	var new_selected_card =  get_child(index).get_child(0)
	move_left(new_selected_card, 50)
	selected_card_index = index
	
func move_right(card_container, offset):
	$Tween.interpolate_property(
		card_container, 
		"rect_position", 
		Vector2(0, 0), 
		Vector2(0, 0),
		0.1,  # time
		Tween.TRANS_EXPO,
		Tween.EASE_OUT
	)
	$Tween.start()

func move_left(card_container, offset):
	$Tween.interpolate_property(
		card_container, 
		"rect_position", 
		Vector2(0, 0), 
		Vector2(-offset, 0),
		0.1,  # time
		Tween.TRANS_EXPO,
		Tween.EASE_OUT
	)
	$Tween.start()

func get_random_card_container():
	# TODO: improve this
	# It is a naive implementation, always gets the first card
	return get_child(randi() % get_card_count())

func _on_CardSelected_place_card(a, b):
	""" Called when the player finishes his turn"""
	# enables tha AI
	enable()