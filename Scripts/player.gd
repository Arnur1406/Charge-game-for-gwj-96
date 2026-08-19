extends CharacterBody2D

enum STATE{
	IDLE,
	JUMP,
	FALL,
	ABILITY,
	CHARGING,
	WALK,
}
@onready var health_bar : HealthBar = get_tree().current_scene.find_child("in_game_ui").find_child("health_bar")

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var temporary_label: Label = $"../../UI/TemporaryLabel"

var max_speed = 200.0
const JUMP_VELOCITY = -300.0
var double_jump_available : bool = true
var current_state : STATE = STATE.IDLE


func _ready() -> void:
	SignalHub.player_died.connect(player_died)


func _physics_process(delta: float) -> void:
	get_movement_input(delta)
	state_change()
	match current_state:
		STATE.FALL: animated_sprite_2d.play("Fall")
		STATE.JUMP: animated_sprite_2d.play("Jump")
		STATE.WALK: animated_sprite_2d.play("Walk")
		STATE.IDLE: animated_sprite_2d.play("Idle")
#		STATE.CHARGING: animated_sprite_2d.play("Charging")
#		STATE.ABILITY: animated_sprite_2d.play("Ability")
	temporary_label.text = "current state:" + str(STATE.find_key(current_state)) + "   hp: " + str(int(health_bar.value)) + "  Batteries %d" % [GameManager.get_batteries()] 
	move_and_slide()



func get_movement_input(delta: float):
	# Add the gravity.
	if not is_on_floor():
		if Input.is_action_just_released("jump") and velocity.y<0:
			velocity.y /= 1.7
		velocity += get_gravity() * delta
	else:
		double_jump_available = true
	# Handle jump.
	if Input.is_action_just_pressed("jump") and (is_on_floor() or double_jump_available):
		velocity.y = JUMP_VELOCITY
		if not is_on_floor():
			double_jump_available = false

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = max_speed * direction
	else:
		velocity.x = move_toward(velocity.x, 0, max_speed)
	if direction > 0:
		animated_sprite_2d.flip_h = false
	if direction < 0:
		animated_sprite_2d.flip_h = true


func _input(_event: InputEvent) -> void:
	charge("charge")


func charge(charge_button: String) -> void:
	if Input.is_action_just_pressed(charge_button):
		GameManager.use_battery()
		print("charge")



func player_died() -> void:
	print("player died")


func state_change() -> void:
	if velocity.x == 0 and velocity.y == 0:
		current_state = STATE.IDLE
	elif velocity.y > 0:
		current_state = STATE.FALL
	elif velocity.y<0:
		current_state = STATE.JUMP
	elif abs(velocity.x) > 0:
		current_state = STATE.WALK
