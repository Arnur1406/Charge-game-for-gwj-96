extends Control

@onready var options_button: Button = $ButtonControl/VBoxContainer/OptionsButton
@onready var quit_button: Button = $ButtonControl/VBoxContainer/QuitButton
@onready var play_button: Button = $ButtonControl/VBoxContainer/PlayButton




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



func _on_play_button_pressed() -> void:
	GameManager.switch_scenes(Constants.GAME_SCENES.main_area)


func _on_quit_button_pressed() -> void:
	get_tree().quit()
