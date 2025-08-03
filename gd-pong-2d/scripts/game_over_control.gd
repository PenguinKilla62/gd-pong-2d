extends Control

var selectedFocusIndex = 0

func get_input():
	var direction = Input.get_axis("up", "down")
	
	var action = Input.is_action_pressed("confirm")
	
	selectedFocusIndex += direction
	
	if selectedFocusIndex > 1 or selectedFocusIndex < 0:
		selectedFocusIndex = 0
	
	if selectedFocusIndex == 0:
		$"GameOverContainer/RetryButton".grab_focus()
	else:
		$"GameOverContainer/ExitButton".grab_focus()
		
	if action && selectedFocusIndex == 0:
		$"GameOverContainer/RetryButton".call("_on_pressed")
	elif action:
		$"GameOverContainer/ExitButton".call("_on_pressed")
		
func _process(delta: float):
	if self.visible:
		get_input()
