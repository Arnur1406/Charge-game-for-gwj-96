extends Node
class_name Constants

enum GAME_SCENES {
	main_menu, main_area, level1,
	}
	
static var SWITCHABLE_GAME_SCENES: Dictionary[int, PackedScene] = {
	GAME_SCENES.main_menu: preload("uid://dh8ri81vmstal"),
	GAME_SCENES.main_area: preload("uid://cm3f0kfw3so3p"),
	GAME_SCENES.level1: preload("uid://8862ndhatf4t")
}
