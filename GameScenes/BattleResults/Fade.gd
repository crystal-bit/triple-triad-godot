extends CanvasModulate

onready var anim_player: AnimationPlayer = $AnimationPlayer
onready var battle: Node = get_parent().get_node("Battle")
onready var results: Node = get_node("CanvasLayer/Results")


func _on_Battle_battle_ended(match_result):
	# wait 1 second
	yield(get_tree().create_timer(1), "timeout")
	
	# fade game to black (and show results node)
	anim_player.play("fade_to_black")
	
	# show result
	if match_result == battle.WIN:
		results.show_win()
	elif match_result == battle.DRAW:
		results.show_draw()
	elif match_result == battle.LOSE:  
		results.show_lose()
	else:
		print("ERROR: this should never happen")
	
	# wait 
	yield(get_tree().create_timer(3.5), "timeout")
	# TODO: remove this reload scene and add a prompt to the player like "press X to play again, press ESC to quit"
	get_tree().reload_current_scene()
