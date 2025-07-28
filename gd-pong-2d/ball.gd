extends CharacterBody2D

@export var speed = 400
@export var increaseSpeedAmount = 1.2
var currentSpeed = speed

func _ready():
	velocity = Vector2(-200, -200).normalized() * speed
func find_label(label, findName):
	return label.name == findName
	
func _physics_process(delta: float):
	var collision = move_and_collide(velocity * delta)
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
			
		
		velocity = velocity.bounce(collision.get_normal())
