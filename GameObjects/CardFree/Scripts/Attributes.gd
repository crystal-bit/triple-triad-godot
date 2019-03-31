extends GridContainer

const ATTRIBUTE_TEXTURE_WIDTH = 64
const TEXTURE_OFFSET = 6
func _ready():
	pass

func set_attributes(attributes_data):
	$Top.texture.region = _get_texture_region_by_value(attributes_data["top"])
	$Left.texture.region = _get_texture_region_by_value(attributes_data["left"])
	$Right.texture.region = _get_texture_region_by_value(attributes_data["right"])
	$Bottom.texture.region = _get_texture_region_by_value(attributes_data["bottom"])

func _get_texture_region_by_value(value):
	return Rect2(
		TEXTURE_OFFSET + (value)*ATTRIBUTE_TEXTURE_WIDTH, 
		TEXTURE_OFFSET, 
		32, 
		32
	)
	
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
