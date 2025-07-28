extends CharacterBody2D

@export var speed = 1200

func _ready():
	velocity = velocity.normalized()

func _physics_process(delta):
	var previousVelocityX = velocity.x
	var direction = 1
	
	if $"../Ball".position.y > position.y:
		direction = 1
	elif $"../Ball".position.y < position.y:
		direction = -1
	else:
		direction = 0
	
	velocity.y = direction * speed #* delta
	
	var collided = move_and_slide()
	
	if (collided == true):
		velocity.x = previousVelocityX
		move_and_slide()
		print("collided ", collided)
