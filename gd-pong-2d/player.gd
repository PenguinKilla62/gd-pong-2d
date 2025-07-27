extends CharacterBody2D

@export var speed = 400

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	var newVelocity = input_direction * speed
	velocity = Vector2(velocity.x, newVelocity.y)

func _physics_process(delta):
	get_input()
	var collided = move_and_slide()
	if (collided == true):
		print("collided", collided)
