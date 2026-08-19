extends Node2D

@onready var spawner: Spawner = $spawner

var position_pool: Array[Vector2] = [Vector2(135, 175)]


func _ready() -> void:
	spawner.spawn_items(position_pool, spawner.SPAWNABLE.battery)



func _process(delta: float) -> void:
	pass
