extends Sprite

export(NodePath) var menu_path  # used to get the list of menu entries (they should be Control nodes for this script to work)
onready var menu_entries = get_node(menu_path).get_children()
var positions = []
var current_position_index


func _ready():
	for entry in menu_entries:
		if entry.visible and entry is Label:
			positions.append(entry.rect_position)
			print(entry.rect_position)
	if len(positions) > 0:
		set_current_position(0)
		show()
	# set an offset for the sprite (to make it align correctly witht the menu entries)
	offset = Vector2(
		-(get_rect().size.x + 60),
		50
	)


func _process(delta):
	if Input.is_action_just_pressed("ui_down"):
		move_down()
	elif Input.is_action_just_pressed("ui_up"):
		move_up()
		
	if Input.is_action_just_pressed("ui_accept"):
		var selected_menu: Label = menu_entries[current_position_index]
		# if the menu is enabled
		if selected_menu.modulate.a == 1:
			print("Option selected: " + selected_menu.name)
			# play confirm sound and load new scene
			$Sounds/Confirm.play()
		else:
			$Sounds/Denied.play()
		

func set_current_position(new_pos):
	# check if position is valid
	if 0 <= new_pos and new_pos < len(positions):
		# update position index variable
		current_position_index = new_pos
		# update sprite position
		position = Vector2(
			positions[current_position_index].x,
			positions[current_position_index].y
		)
		return true  # Cursor was moved
	else:
		return false  # Cursor was not moved


func move_down():	
	if set_current_position(current_position_index + 1):
		$Sounds/Confirm.play()


func move_up():
	if set_current_position(current_position_index - 1):
		$Sounds/Confirm.play()