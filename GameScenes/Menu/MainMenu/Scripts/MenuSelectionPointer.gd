extends Sprite

onready var current_menu: Node = get_parent()
var entries = []
var current_position_index


func _ready():
	# reset array (needed when re-initializing the node)
	entries = []
	# save references to menu entry nodes
	for entry in current_menu.get_children():
		if entry.visible and entry is Label:
			entries.append(entry)
	set_current_position(0)


func _process(delta):
	if Input.is_action_just_pressed("ui_down"):
		move_down()
	elif Input.is_action_just_pressed("ui_up"):
		move_up()
		
	if Input.is_action_just_pressed("ui_accept"):
		var selected_entry = entries[current_position_index]
		# if the menu is enabled
		if selected_entry.modulate.a == 1:
			print("Option selected: " + selected_entry.name)
			if selected_entry.has_method("callback"):
				selected_entry.callback()
			# play confirm sound and load new scene
			$Sounds/Confirm.play()
		else:
			$Sounds/Denied.play()
		

func set_current_position(new_pos):
	# check if position is valid
	if 0 <= new_pos and new_pos < len(entries):
		# update position index variable
		current_position_index = new_pos
		# get the selected entry
		var selected_entry = entries[current_position_index]
		# update sprite position
		position = Vector2( 
			selected_entry.rect_position.x - (get_rect().size.x/2)*scale.x - 20,
			selected_entry.rect_position.y + selected_entry.rect_size.y/2
		)
		return true  # Cursor was moved
	else:
		return false  # Cursor was not moved


func set_current_menu(new_menu: Node):
	current_menu = new_menu
	# reparent node
	SceneManager.reparent_node_to(self, new_menu)
	# new_menu.add_child(self)
	# re-init node
	_ready()
	

func move_down():	
	if set_current_position(current_position_index + 1):
		$Sounds/Confirm.play()


func move_up():
	if set_current_position(current_position_index - 1):
		$Sounds/Confirm.play()

func _on_SinglePlayerLabel_menu_changed(menu: Node):
	set_current_menu(menu)
