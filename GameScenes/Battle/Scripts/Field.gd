extends GridContainer

var cards_played = 0
# const MAX_CARDS_ON_FIELD = 9

func add_card_at_position(card_container, field_position):
	# https://davcri.github.io/posts/godot-reparent-node/
	var card = card_container.get_child(0)
	card_container.remove_child(card)
	# free memory
	card_container.queue_free()	
	# reset card offset
	card.rect_position = Vector2()
	get_container_by_vector(field_position).add_child(card)
	# increase played cards counter
	cards_played += 1

func get_random_empty_container():  # TODO: change name! get_vector_...
	assert cards_played < 9
	# get random vector position
	var container_position = Vector2(randi() % 3, randi() % 3)
	# get container at position
	var container = get_container_by_vector(container_position)
	# until you find an empty card container
	while container.get_child_count() != 0:
		# take a random container
		container_position = Vector2(randi() % 3, randi() % 3)
		container = get_container_by_vector(container_position)
	return container_position

func get_container_by_vector(field_position):
	""" Gets a Container node by the given Vector2 field_position.
	Vector2(0, 0) is the top-left corner
	Vector2(2, 2) is the bottom-right corner
	"""
	# calculate container_index by field_position vector 
	var container_index = (int(field_position.x + 1) % 4) + field_position.y * 3
	return get_node("Container" + str(container_index))

func is_position_empty(position):
	print(get_container_by_vector(position).get_child_count())
	return get_container_by_vector(position).get_child_count() == 0
	
func get_card_containers():
	return get_children()

func get_card_containers_matrix():
	var matrix = [
		[$Container1, $Container2, $Container3],
		[$Container4, $Container5, $Container6],
		[$Container7, $Container8, $Container9]
	]
	return matrix
	