extends Node

var current_scene: Node = null


func _ready(): 
	# get the root node
	var root = get_tree().get_root()
	# save the current scene
	current_scene = root.get_child(root.get_child_count() - 1)


func goto_scene(path: String, params = null):
	# full documentation here: http://docs.godotengine.org/en/3.0/getting_started/step_by_step/singletons_autoload.html
	# Deleting the current scene at this point might be
	# a bad idea, because it may be inside of a callback or function of it.
	# The worst case will be a crash or unexpected behavior.
	# The way around this is deferring the load to a later time
	call_deferred("_deferred_goto_scene", path, params)
	

func _deferred_goto_scene(path: String, params = null):
	# Immediately free the current scene,
	# there is no risk here.
	current_scene.free()
	# Load new scene
	var s = ResourceLoader.load(path)
	# Instance the new scene.
	current_scene = s.instance()
	# Add it to the active scene, as child of root.
	get_tree().get_root().add_child(current_scene)
	# Optional, to make it compatible with the SceneTree.change_scene() API.
	get_tree().set_current_scene(current_scene)
	if params:
		current_scene.init(params)


func add_node_to_scene(node):
	# add the new node to the scene
	current_scene.add_child(node)


func load_node(node_scene_path):
	var new_node_scene = load(node_scene_path)
	var new_node = new_node_scene.instance()
	return new_node
	

func reparent_node_to(node: Node, new_parent: Node):
	""" Reparent a node.
	You can call this metod from a node to reparent it:
		SceneManager.reparent_node_to(item, player)
	"""
	var old_parent = node.get_parent()
	old_parent.remove_child(node)
	# TODO: free memory?
	new_parent.add_child(node)
	
	
	
	