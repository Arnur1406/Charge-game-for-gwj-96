extends Node

@onready var tree = get_tree() 
@onready var animation : AnimatedSprite2D = SceneTransition.find_child("AnimationForTransition")

func switch_scenes(scene_name: int) -> void:
	SceneTransition.visible = true
	animation.play("AnimationTransition")
	await animation.animation_finished
	tree.change_scene_to_packed(Constants.SWITCHABLE_GAME_SCENES[scene_name])
	animation.play_backwards("AnimationTransition")
	await animation.animation_finished
	SceneTransition.visible = false
