extends Area2D
class_name Enemy
@onready var animated_sprite = $AnimatedSprite2D
@onready var collision: CollisionShape2D = $CollisionShape2D

@export var enemy_damage = 20
@export var enemy_speed = 100.0
@export var enemy_charge = 0
@onready var left_side_ray : RayCast2D
@onready var right_side_ray : RayCast2D
