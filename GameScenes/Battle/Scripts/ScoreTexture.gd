extends TextureRect


const TEXTURES_PATH = "res://Assets/Tripod v1.1/textures contents/"
const CARDS_TEXT_PATH = TEXTURES_PATH + "ca/cardstext/cardstext_13-edit.png"
const SCORE_TEXT_WIDTH = 94
const SCORE_TEXT_HEIGHT = 99
const TEXTURE_START_OFFSET_H = 12
const TEXTURE_START_OFFSET_Y = 190

var value: int = 5  # valid numbers are from 1 to 9

func _ready():
	# update texture region
	update_score_texture(value)

func update_score_texture(value):
	assert(value >= 1 and value <= 9)
	texture.region = Rect2(
		TEXTURE_START_OFFSET_H + SCORE_TEXT_WIDTH * (value - 1),
		TEXTURE_START_OFFSET_Y,
		SCORE_TEXT_WIDTH,
		SCORE_TEXT_HEIGHT
	)

func increase():
	value += 1
	update_score_texture(value)

func decrease():
	value -= 1
	update_score_texture(value)
