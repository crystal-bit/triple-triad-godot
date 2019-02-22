extends Node


var matches_stats = {
	"won": 0,
	"lost": 0,
	"drawn": 0
} setget set_matches_stats, get_matches_stats


signal matches_stats_changed


func _process(delta):
	if Input.is_key_pressed(KEY_ESCAPE):
		emit_signal("matches_stats_changed")


func set_matches_stats(value: Dictionary):
	matches_stats = value
	emit_signal("matches_stats_changed")


func get_matches_stats() -> Dictionary:
	return matches_stats
	
	
func load_data():
	# TODO: Load data from a save file
	pass


func save_data():
	# TODO: Save data to a save file
	pass