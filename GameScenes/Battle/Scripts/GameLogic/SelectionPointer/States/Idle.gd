extends Node

onready var selection_pointer = get_parent().get_parent()

func init(params):
	selection_pointer.modulate.a = 0

func _process(delta):
	pass

func exit():
	pass