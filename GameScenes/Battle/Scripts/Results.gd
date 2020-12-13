extends Control

# dependencies
onready var win_texture: Node = $CenterContainer/VBoxContainer/WinTexture
onready var lose_texture: Node = $CenterContainer/VBoxContainer/LoseTexture
onready var draw_texture: Node = $CenterContainer/VBoxContainer/DrawTexture
onready var matches_stats_node: Node = $CenterContainer/VBoxContainer/MarginContainer/VBoxContainer
onready var menu_pointer: Node = $CenterContainer/VBoxContainer/VBoxContainer/MenuSelectionPointer

var result: String = "win" setget set_result, get_result


func _ready():
	_update_visible_texture()
	_set_stats()
	GlobalState.connect("matches_stats_changed", self, "_set_stats")  

func set_result(value: String):
	if value in ["win", "draw", "lose"]:
		result = value
		_update_visible_texture()
	else:
		print("ERROR setting result")

func get_result() -> String:
	return result
	
func show_win():
	_show_texture("win")

func show_draw():
	_show_texture("draw")
	
func show_lose():
	_show_texture("lose")
	
func process_input(process: bool):
	if process:
		menu_pointer.set_process(true)
	else:
		menu_pointer.set_process(false)

func _show_texture(texture_string: String):
	set_result(texture_string)

func _update_visible_texture():
	_hide_all_textures()
	if result == "win":
		win_texture.show()
	elif result == "draw":
		draw_texture.show()
	elif result == "lose":
		lose_texture.show()
	
func _hide_all_textures():
	win_texture.hide()
	lose_texture.hide()
	draw_texture.hide()
	
func _set_stats():
	var matches_stats = GlobalState.matches_stats
	var won: Label = matches_stats_node.get_node("MatchesWon/Value")
	var draw: Label = matches_stats_node.get_node("MatchesDraw/Value")
	var lost: Label = matches_stats_node.get_node("MatchesLost/Value")
	var total: Label = matches_stats_node.get_node("MatchesTotal/Value")
	
	won.text = str(matches_stats["won"])
	draw.text = str(matches_stats["drawn"])
	lost.text = str(matches_stats["lost"])
	total.text = str(matches_stats["won"] + matches_stats["drawn"] + matches_stats["lost"])
	
