extends Label

export(PackedScene) var next_scene


func callback():
	SceneManager.goto_scene(next_scene.resource_path)