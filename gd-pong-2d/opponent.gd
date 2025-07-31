extends CharacterBody2D

@export var speed = 1200
@export var pauseMovement = false

@export var isPlayer2 = false

func _ready():
	velocity = velocity.normalized()
	
func get_input(delta):
	var input_direction = Input.get_axis("p2_up", "p2_down")
	velocity.y = input_direction * speed #* delta
	
func computer_move():
	var direction = 1
	if $"../Ball".position.y > position.y:
		direction = 1
	elif $"../Ball".position.y < position.y:
		direction = -1
	else:
		direction = 0
	
	velocity.y = direction * speed

func _physics_process(delta):
	var previousVelocityX = velocity.x
	
	if isPlayer2:
		get_input(delta)
	else:
		computer_move()
	
	var collided = false
	if pauseMovement == false:
		collided = move_and_slide()
	
	if (collided == true):
		velocity.x = previousVelocityX
		move_and_slide()
		print("collided ", collided)
