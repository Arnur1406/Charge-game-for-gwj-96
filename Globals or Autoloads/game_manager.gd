extends Node

@onready var tree = get_tree() 
@onready var animation : AnimatedSprite2D = SceneTransition.find_child("AnimationForTransition")

var current_batteries: int = 0
var charge_bar: ChargeBar


func switch_scenes(scene_name: int) -> void:
	SceneTransition.visible = true
	animation.play("AnimationTransition")
	await animation.animation_finished
	tree.change_scene_to_packed(Constants.SWITCHABLE_GAME_SCENES[scene_name])
	animation.play_backwards("AnimationTransition")
	await animation.animation_finished
	SceneTransition.visible = false



func get_batteries() -> int:
	return current_batteries

func empty_battery() -> void:
	current_batteries = 0


func use_battery() -> void:
	if current_batteries <= 0:
		print("no batteries")
	else:
		current_batteries -= 1

func add_battery() -> void:
	current_batteries += 1
