extends CharacterBody2D


var max_speed = 200.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	get_movement_input(delta)
	move_and_slide()


func get_movement_input(delta: float):
	# Add the gravity.
	if not is_on_floor():
		if Input.is_action_just_released("jump") and velocity.y<0:
			velocity.y /= 1.7
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = max_speed * direction
	else:
		velocity.x = move_toward(velocity.x, 0, max_speed)

func _input(event: InputEvent) -> void:
	charge("charge")


func charge(charge_button: String) -> void:
	if Input.is_action_just_pressed(charge_button):
		print("charge")
