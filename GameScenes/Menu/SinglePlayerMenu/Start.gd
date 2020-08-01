extends TextureButton

func callback():
	# create rules dictionary
	var rules = {}
	for node in get_parent().get_children():
		if node is CheckButton:
			rules[node.name] = node.pressed
	GlobalState.current_rules = rules
	SceneManager.goto_scene("res://GameScenes/Game/Game.tscn", rules)
