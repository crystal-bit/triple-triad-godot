extends Label

export(NodePath) var submenu_path

onready var submenu = get_node(submenu_path)

signal menu_changed(Node)


func callback():
	# hide main menu
	get_parent().hide()
	# show submenu
	submenu.show()
	# notifies the selection pointer to change the menu to work on
	emit_signal("menu_changed", submenu)
	
	