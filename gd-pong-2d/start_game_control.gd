extends Control

var selectedFocusIndex = 0

func get_input():
	var direction = Input.get_axis("up", "down")
	
	var action = Input.is_action_pressed("confirm")
	
	selectedFocusIndex += direction
	
	if selectedFocusIndex > 1 or selectedFocusIndex < 0:
		selectedFocusIndex = 0
	
	if selectedFocusIndex == 0:
		$"StartVBoxContainer/StartButton".grab_focus()
	else:
		$"StartVBoxContainer/ExitButton".grab_focus()
		
	if action && selectedFocusIndex == 0:
		$"StartVBoxContainer/StartButton".call("_on_pressed")
	elif action:
		$"StartVBoxContainer/ExitButton".call("_on_pressed")

func set_game_elements_visible(isVisible : bool):
	$"../VBoxContainer".visible = isVisible
	$"../VBoxContainer2".visible = isVisible
	$"../../Player/".visible = isVisible
	$"../../Opponent".visible = isVisible
	$"../../Ball".visible = isVisible
	$"../GameOverControl".visible = isVisible
	
func set_game_elements_pause(isPaused : bool):
	$"../../Player/".pauseMovement = isPaused
	$"../../Opponent".pauseMovement = isPaused
	$"../../Ball".pauseMovement = isPaused

func _ready():
	self.visible = true
	$"../VBoxContainer2/PlayerScoreLabelNum".text = "0"
	$"../VBoxContainer/OpponentScoreLabelNum".text = "0"
	
	set_game_elements_visible(false)
	set_game_elements_pause(true)
	
func _process(delta: float):
	if self.visible:
		get_input()
	
