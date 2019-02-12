extends VBoxContainer


onready var disabled_entries = [
	$MultiPlayerLabel,
	$OptionsLabel,
	$AboutLabel,
	$SecretMenu
]

func _ready():
	# disable entries
	for entry in disabled_entries:
		print(entry)
		entry.modulate.a = 0.3
		entry.focus_mode = Control.FOCUS_NONE
		

