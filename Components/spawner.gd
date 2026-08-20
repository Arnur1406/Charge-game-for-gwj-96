extends Node
class_name Spawner


enum SPAWNABLE {battery}
var SPAWNABLE_DICTIONARY: Dictionary[int, PackedScene] = {
	SPAWNABLE.battery: preload("uid://dlcvnnmxt31h2")
}


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func spawn_items(positions: Array[Vector2], item: int) -> void:
	for pos in positions:
		spawn(item).global_position = pos
		


func spawn(item: int) -> Node2D:
	var spawnable = SPAWNABLE_DICTIONARY[item].instantiate()
	add_child(spawnable)
	return spawnable
