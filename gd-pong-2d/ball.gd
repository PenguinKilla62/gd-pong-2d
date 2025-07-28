extends CharacterBody2D

@export var speed = 400
@export var increaseSpeedAmount = 1.2
@export var pauseMovement = false
var currentSpeed = speed

func _ready():
	velocity = Vector2(-200, -200).normalized() * speed
	
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
	
func _physics_process(delta: float):
	var collision = false
	if pauseMovement == false:
		collision = move_and_collide(velocity * delta)
	if collision:
		var name : String = collision.get_collider().name
		if name.contains("left_wall"):
			var divideBy = currentSpeed / speed
			velocity = velocity / divideBy
			currentSpeed = speed
			
			var labelNum = int($"../CanvasLayer/VBoxContainer/OpponentScoreLabelNum".text)
			labelNum += 1
			$"../CanvasLayer/VBoxContainer/OpponentScoreLabelNum".text = str(labelNum)
			
			position.x = 960
			position.y = 540
			velocity = Vector2(200, 200).normalized() * speed
		elif name.contains("right_wall"):
			var divideBy = currentSpeed / speed
			velocity = velocity / divideBy
			currentSpeed = speed
			
			var labelNum = int($"../CanvasLayer/VBoxContainer2/PlayerScoreLabelNum".text)
			labelNum += 1
			$"../CanvasLayer/VBoxContainer2/PlayerScoreLabelNum".text = str(labelNum)
			
			position.x = 960
			position.y = 540
			velocity = Vector2(-200, -200).normalized() * speed
		elif name.contains("Player"):
			currentSpeed = currentSpeed * increaseSpeedAmount
			velocity = velocity * increaseSpeedAmount
			
		if name.contains("left_wall") or name.contains("right_wall"):
			check_game_over()
			
		
		velocity = velocity.bounce(collision.get_normal())
