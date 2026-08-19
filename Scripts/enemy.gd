extends Area2D
class_name Enemy
@onready var animated_sprite = $AnimatedSprite2D
@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var charge_bar: ChargeBar = get_tree().current_scene.find_child("in_game_ui").find_child("charge_bar")
@export var enemy_damage = 20
@export var enemy_speed : float = 100.0
@export var enemy_charge : float = 0.0
@onready var left_side_ray : RayCast2D
@onready var right_side_ray : RayCast2D

var direction : int = 1


func _ready() -> void:
	animated_sprite = $TemporaryTexture
	right_side_ray = $RightSide
	left_side_ray = $LeftSide



func _process(delta: float) -> void:
	position.x += delta * enemy_speed * direction
	if not right_side_ray.is_colliding():
		direction = -1
	if not left_side_ray.is_colliding():
		direction = 1


func _on_body_entered(body: Node2D) -> void:
	SignalHub.deal_damage.emit(enemy_damage, 0.0)
