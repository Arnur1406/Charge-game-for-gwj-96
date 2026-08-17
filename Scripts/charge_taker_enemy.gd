extends Enemy


var direction : int = 1


func _ready() -> void:
	animated_sprite = $TemporaryTexture
	right_side_ray = $RightSide
	left_side_ray = $LeftSide


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += delta * enemy_speed * direction
	if not right_side_ray.is_colliding():
		direction = -1
	if not left_side_ray.is_colliding():
		direction = 1
