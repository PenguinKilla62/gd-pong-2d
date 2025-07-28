extends Button

func set_pause_movements(isPaused : bool):
	$"../../../../Player".pauseMovement = isPaused
	$"../../../../Opponent".pauseMovement = isPaused
	$"../../../../Ball".pauseMovement = isPaused

func _on_pressed():
	$"../../../VBoxContainer2/PlayerScoreLabelNum".text = "0"
	$"../../../VBoxContainer/OpponentScoreLabelNum".text = "0"
	set_pause_movements(false)
	$"../../../GameOverControl".visible = false
	
