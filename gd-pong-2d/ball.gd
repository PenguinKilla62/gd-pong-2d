extends CharacterBody2D

@export var speed = 400
@export var increaseSpeedAmount = 1.2
@export var pauseMovement = false
var currentSpeed = speed

var og_player_position = Vector2(1,1)
var og_opponent_position = Vector2(1,1)

var inputPause = false

var playerOpponentBounces = 0

func _ready():
	velocity = Vector2(-200, -200).normalized() * speed
	og_player_position = $"../Player".position
	og_opponent_position = $"../Opponent".position
	
func reset_positions():
	$"../Player".position = og_player_position
	$"../Opponent".position = og_opponent_position
	
	position.x = 960
	position.y = 540
	
func set_pause_movements(isPaused):
	$"../Player".pauseMovement = isPaused
	$"../Opponent".pauseMovement = isPaused
	pauseMovement = isPaused
	
func check_game_over():
	var playerScore = int($"../CanvasLayer/VBoxContainer2/PlayerScoreLabelNum".text)
	var opponentScore = int($"../CanvasLayer/VBoxContainer/OpponentScoreLabelNum".text)
	
	if playerScore == 10 and playerScore > opponentScore:
		$"../CanvasLayer/GameOverControl/GameOverContainer/VictoryLabel".text = "Player Won!"
		set_pause_movements(true)
		$"../CanvasLayer/GameOverControl".show()
		
	elif opponentScore == 10 and opponentScore > playerScore:
		$"../CanvasLayer/GameOverControl/GameOverContainer/VictoryLabel".text = "Opponent Won!"
		set_pause_movements(true)
		$"../CanvasLayer/GameOverControl".show()
		
func _input(inputEvent : InputEvent):
	if inputEvent.is_action_pressed("p2_add"):
		$"../Opponent".isPlayer2 = !$"../Opponent".isPlayer2
		$"../CanvasLayer/VBoxContainer/Player2Join".visible = !$"../Opponent".isPlayer2
		
	elif inputEvent.is_action_pressed("pause"):
		inputPause = !inputPause
		set_pause_movements(inputPause)
		
func playerOpponentBounce():
	playerOpponentBounces += 1
	var subColorVal = 255 - (playerOpponentBounces * 15)
	if subColorVal < 0:
		subColorVal = 0
	$"Sprite2D".modulate = Color.from_rgba8(255, subColorVal, subColorVal, 255)
	$"GPUParticles2D".modulate = Color.from_rgba8(255, subColorVal, subColorVal, 255)
	
func resetColor():
	$"Sprite2D".modulate = Color(1,1,1,1)
	$"GPUParticles2D".modulate = Color(1,1,1,1)
	playerOpponentBounces = 0
		
	
func _physics_process(delta: float):
	var collision = false
	if pauseMovement == false:
		collision = move_and_collide(velocity * delta)
	if collision:
		$"Hit".play(0.0)
		var name : String = collision.get_collider().name
		if name.contains("left_wall"):
			var divideBy = currentSpeed / speed
			velocity = velocity / divideBy
			currentSpeed = speed
			
			var labelNum = int($"../CanvasLayer/VBoxContainer/OpponentScoreLabelNum".text)
			labelNum += 1
			$"../CanvasLayer/VBoxContainer/OpponentScoreLabelNum".text = str(labelNum)
			
			reset_positions()
			velocity = Vector2(200, 200).normalized() * speed
		elif name.contains("right_wall"):
			var divideBy = currentSpeed / speed
			velocity = velocity / divideBy
			currentSpeed = speed
			
			var labelNum = int($"../CanvasLayer/VBoxContainer2/PlayerScoreLabelNum".text)
			labelNum += 1
			$"../CanvasLayer/VBoxContainer2/PlayerScoreLabelNum".text = str(labelNum)
			
			reset_positions()
			velocity = Vector2(-200, -200).normalized() * speed
		elif name.contains("Player") || name.contains("Opponent"):
			currentSpeed = currentSpeed * increaseSpeedAmount
			velocity = velocity * increaseSpeedAmount
			playerOpponentBounce()
			
		if name.contains("left_wall") or name.contains("right_wall"):
			check_game_over()
			resetColor()
			
		
			
		
		velocity = velocity.bounce(collision.get_normal())
