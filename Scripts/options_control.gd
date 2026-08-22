extends Control


@onready var return_button: Button = $ReturnButton
@onready var options_button: Button = $OptionsButton
@onready var help_button: Button = $HelpButton
@onready var options_label: Label = $OptionsLabel
@onready var help_label: Label = $HelpLabel



func _on_return_button_pressed() -> void:
	visible = false


func _on_options_button_pressed() -> void:
	options_label.visible = true
	help_label.visible = false


func _on_help_button_pressed() -> void:
	options_label.visible = false
	help_label.visible = true
