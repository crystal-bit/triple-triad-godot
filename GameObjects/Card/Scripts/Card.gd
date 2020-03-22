extends TextureButton

export var card_id = 5
export var covered = false setget set_covered
export var owned_by_player = true

const CARDS_DATA_PATH = "res://GameObjects/Card/Data/triple-triad-cards-data.json"
const CARDS_PATH = "res://GameObjects/Card/Textures/"
const CARD_HEIGHT = 256
const CARD_WIDTH = 256
const CARDS_PER_ROW = 2

signal owner_changed

enum ELEMENTS {
	NONE,
	WIND,
	THUNDER,
	FIRE,
	WATER
}

var card = {}

func _ready():
	var card_data
	var cards = _load_cards_data_from_json()
	for c in cards:
		if c.id == card_id:
			card_data = c
	card.group = card_data["group"]
	card.group_index = card_data["group_index"]
	card.name = card_data["name"]
	card.attributes = {
		"top": int(card_data["attributes"][0]),
		"right": int(card_data["attributes"][1]),
		"bottom": int(card_data["attributes"][2]),
		"left": int(card_data["attributes"][3]),
	}
	# set attributes GUI
	$Attributes.set_attributes(card.attributes)
	# update debug label
	$DebugLabel.text = card.name
	card.element = ELEMENTS.NONE
	card.front_texture = _get_atlas_texture_by_group_and_index(card.group, card.group_index)
	card.back_texture = _get_atlas_texture_by_group_and_index(13, 6)
	if covered:
		$Attributes.hide()
		texture_normal = card.back_texture
	else:
		$Attributes.show()
		texture_normal = card.front_texture
	set_owned_by_player(owned_by_player)

func _get_atlas_texture_by_group_and_index(c_group, c_index):
	# load the correct texture
	var t = AtlasTexture.new()
	# load a texture resource into the "atlas" Texture field
	t.atlas = load(CARDS_PATH + "cards_{grp}.png".format({"grp": int(c_group)}))
	# set the region
	t.region = Rect2(
		(int(c_index) % CARDS_PER_ROW)*CARD_WIDTH,
		(int(c_index) / CARDS_PER_ROW)*CARD_HEIGHT,
		CARD_WIDTH,
		CARD_HEIGHT
	)
	return t

func get_card_attributes():
	return card.attributes

func capture():
	set_owned_by_player(!owned_by_player)
	$AudioCapture.play()

func _load_cards_data_from_json():
	var file = File.new()
	var exit_code = file.open(CARDS_DATA_PATH, file.READ)
	if exit_code != 0:
		print("Error", exit_code, "while opening", CARDS_DATA_PATH)
	var file_data = file.get_as_text()
	var error_str = validate_json(file_data)
	if not error_str:
		# JSON is valid
		return parse_json(file_data)
	else:
		prints("Invalid JSON\n", error_str)

func set_covered(is_covered):
	covered = is_covered
	if covered:
		$Attributes.hide()
		texture_normal = card.back_texture
	else:
		$Attributes.show()
		texture_normal = card.front_texture

func set_owned_by_player(owned):
	owned_by_player = owned
	if owned:
		$PlayerGradient.show()
		$EnemyGradient.hide()
	else:
		$PlayerGradient.hide()
		$EnemyGradient.show()
	emit_signal("owner_changed", owned)

func _on_SpinBox_value_changed(value):
	card_id = value
	_ready()

func _on_CheckBox_toggled(button_pressed):
	set_owned_by_player(button_pressed)
