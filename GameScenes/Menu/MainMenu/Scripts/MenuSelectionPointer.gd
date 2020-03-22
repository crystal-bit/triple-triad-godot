extends Sprite

onready var current_menu: Node = get_parent()
var entries = []
var index = 0


func _ready():
	# reset array (needed when re-initializing the node)
	entries = []
	# save references to menu entry nodes
	for entry in current_menu.get_children():
		if entry.visible and entry is Control:
			entries.append(entry)
	set_selectetd_entry(0)


func _process(delta):
	if Input.is_action_just_pressed("ui_down"):
		move_down()
	elif Input.is_action_just_pressed("ui_up"):
		move_up()

	if Input.is_action_just_pressed("ui_accept"):
		var selected_entry = entries[index]

		if selected_entry.modulate.a == 1 and not selected_entry.get("disabled"):
			if selected_entry is CheckButton:
				# toggle check button
				selected_entry.pressed = !selected_entry.pressed
			elif selected_entry.has_method("callback"):
				selected_entry.callback()
			else:
				print("Selected entry does not have a callback", selected_entry)
		else:
			$Sounds/Denied.play()


func set_selectetd_entry(new_index):
	# check if position is valid
	if 0 <= new_index and new_index < len(entries):
		index = new_index
		var selected_entry = entries[index]
		# update sprite position
		position = Vector2(
			selected_entry.rect_position.x - (get_rect().size.x/2)*scale.x - 20,
			selected_entry.rect_position.y + selected_entry.rect_size.y/2
		)
		return true  # Cursor was moved
	else:
		print("ERROR set_selection(): invalid index.")
		return false  # Cursor was not moved


func move_down():
	# if cursor moved
	if set_selectetd_entry(index + 1):
		$Sounds/Confirm.play()


func move_up():
	# if cursor moved
	if set_selectetd_entry(index - 1):
		$Sounds/Confirm.play()
