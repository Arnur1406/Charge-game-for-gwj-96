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
@onready var ability_sprite: AnimatedSprite2D = $AbilityArea/AbilitySprite
@onready var ability_area: Area2D = $AbilityArea
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var temporary_label: Label = $"../../UI/TemporaryLabel"
@onready var ability_shape: CollisionShape2D = $AbilityArea/AbilityShape
@onready var hp_label : Label = get_tree().current_scene.find_child("in_game_ui").find_child("HpLabel")
@onready var charge_bar : ChargeBar = get_tree().current_scene.find_child("in_game_ui").find_child("charge_bar")

var max_speed : float = 200.0
const JUMP_VELOCITY : float = -300.0
var double_jump_available : bool = true
var current_state : STATE = STATE.IDLE
var can_use_ability : bool = true


func _ready() -> void:
	SignalHub.player_died.connect(player_died)
	ability_shape.disabled = true


func _physics_process(delta: float) -> void:
	get_movement_input(delta)
	state_change()
	match current_state:
		STATE.FALL: animated_sprite_2d.play("Fall")
		STATE.JUMP: animated_sprite_2d.play("Jump")
		STATE.WALK: animated_sprite_2d.play("Walk")
		STATE.IDLE: animated_sprite_2d.play("Idle")
#		STATE.CHARGING: animated_sprite_2d.play("Charging")
		STATE.ABILITY: animated_sprite_2d.play("Ability")
	temporary_label.text = "current state:" + str(STATE.find_key(current_state)) + "   hp: " + str(int(health_bar.value)) + "  Batteries %d" % [GameManager.get_batteries()] 
	hp_label.text = str(int(health_bar.value))
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
	if Input.is_action_just_pressed(charge_button) and GameManager.get_batteries() > 0:
		GameManager.use_battery()
		SignalHub.used_battery.emit(70, 0.0)
		print("charge")



func player_died() -> void:
	print("player died")


func state_change() -> void:
	if current_state == STATE.ABILITY:
		return
	if Input.is_action_just_pressed("ability") and can_use_ability and charge_bar.value >= 30:
		current_state = STATE.ABILITY
		ability()
		charge_bar.increment_value(-30.0, 0.0)
		return
	if velocity.y > 0:
		current_state = STATE.FALL
	elif velocity.y<0:
		current_state = STATE.JUMP
	elif velocity.x != 0:
		current_state = STATE.WALK
	else:
		current_state = STATE.IDLE


func ability() -> void:
	can_use_ability = false
	ability_area.visible = true
	ability_shape.disabled = false
	ability_sprite.play("default")
	await ability_sprite.animation_finished
	current_state = STATE.IDLE
	ability_shape.disabled = true
	ability_area.visible = false
	await get_tree().create_timer(5.0).timeout
	can_use_ability = true


func _on_ability_area_area_entered(area: Area2D) -> void:
	if area.has_method("thing"):
		area.thing()
