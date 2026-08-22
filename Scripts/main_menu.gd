extends Control

@onready var options_button: Button = $ButtonControl/VBoxContainer/OptionsButton
@onready var quit_button: Button = $ButtonControl/VBoxContainer/QuitButton
@onready var play_button: Button = $ButtonControl/VBoxContainer/PlayButton
@onready var options_control : Control = $UI/OptionsControl



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	options_control.visible = false



func _on_play_button_pressed() -> void:
	GameManager.switch_scenes(Constants.GAME_SCENES.level1)


func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_options_button_pressed() -> void:
	options_control.visible = true
