extends Node


func switch_scenes(scene_name: int) -> void:
	get_tree().change_scene_to_packed(Constants.SWITCHABLE_GAME_SCENES[scene_name])
