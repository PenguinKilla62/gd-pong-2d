extends Button

func set_game_elements_visible(isVisible):
	$"../../../VBoxContainer".visible = isVisible
	$"../../../VBoxContainer2".visible = isVisible
	$"../../../../Player/".visible = isVisible
	$"../../../../Opponent".visible = isVisible
	$"../../../../Ball".visible = isVisible
	
func set_game_elements_pause(isPaused):
	$"../../../../Player/".pauseMovement = isPaused
	$"../../../../Opponent".pauseMovement = isPaused
	$"../../../../Ball".pauseMovement = isPaused

func _on_pressed():
	set_game_elements_pause(false)
	set_game_elements_visible(true)
	
	$"../../../StartGameControl".visible = false
