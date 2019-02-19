extends CanvasLayer

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	$CenterContainer/WinTexture.hide()
	$CenterContainer/LoseTexture.hide()
	$CenterContainer/DrawTexture.hide()


func show_texture(texture_string):
	$AnimationPlayer.play("fade_in")
	if texture_string == "win":
		$CenterContainer/WinTexture.show()
	elif texture_string == "draw":
		$CenterContainer/DrawTexture.show()
	elif texture_string == "lose":
		$CenterContainer/LoseTexture.show()