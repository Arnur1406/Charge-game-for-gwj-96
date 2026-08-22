extends Area2D


@export var damage : int = 20
@export var energy : int = 40
@export var speed : float = -10.0
@export var velocity_y : float = -20.0
@onready var charge_bar: ChargeBar = get_tree().current_scene.find_child("in_game_ui").find_child("charge_bar")
@onready var timer : Timer = $Timer
@onready var player : CharacterBody2D = get_tree().current_scene.find_child("Player")
var did_collide : bool = false
@onready var another_timer: Timer = $AnotherTimer
@onready var third_timer: Timer = $ThirdTimer


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("charge"):
		SignalHub.deal_damage.emit(damage, 0.0)
		charge_bar.increment_value(energy, 0.0)
		timer.start()
		did_collide = true
		player.velocity.y = 0
		player.double_jump_available = false
		third_timer.start()


func _physics_process(delta: float) -> void:
	position.y += delta * speed
	if did_collide:
		player.velocity.y += velocity_y


func _on_timer_timeout() -> void:
	did_collide = false


func _on_area_entered(area: Area2D) -> void:
	if area.has_method("_on_body_entered"):
		another_timer.start()
		await another_timer.timeout
		area.call_deferred("queue_free")


func _on_body_exited(_body: Node2D) -> void:
	third_timer.stop()


func _on_third_timer_timeout() -> void:
		SignalHub.deal_damage.emit(damage, 0.0)
		charge_bar.increment_value(energy, 0.0)
		timer.start()
		did_collide = true
		player.velocity.y = 0
		player.double_jump_available = false
		third_timer.start()
