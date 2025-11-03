extends Node2D
var is_paused := false
func _process(_delta):
	if Input.is_action_just_pressed("Menu"):
		if is_paused:
			print("quitar pausa")
			_unpause_game()
		else:
			print(" pausa")
			_pause_game()

func _pause_game():
	is_paused = true
	get_tree().paused = true
	$OpcionesPausa.show()

func _unpause_game():
	is_paused = false
	get_tree().paused = false
	$OpcionesPausa.hide()
