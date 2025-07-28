extends CharacterBody2D

@export var speed = 1200
@export var pauseMovement = false

func _ready():
	velocity = velocity.normalized()

func get_input(delta):
	var input_direction = Input.get_axis("up", "down")
	velocity.y = input_direction * speed #* delta

func _physics_process(delta):
	var previousVelocityX = velocity.x
	if pauseMovement == false:
		get_input(delta)
	
	var collided = move_and_slide()
	
	if (collided == true):
		velocity.x = previousVelocityX
		move_and_slide()
		print("collided ", collided)
