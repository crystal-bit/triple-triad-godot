extends Label


export(PackedScene) var next_scene


func callback():
	 # start the single player game
	SceneManager.goto_scene(next_scene.resource_path)