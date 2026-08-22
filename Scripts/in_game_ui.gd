extends Control


@onready var color_rect: ColorRect = $ColorRect
@onready var v_box_gameover: VBoxContainer = $ColorRect/VBoxGameover
@onready var v_box_level_complete: VBoxContainer = $ColorRect/VBoxLevelComplete


var player_died: bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player_died = false
	SignalHub.player_died.connect(game_over)
	SignalHub.finished_level.connect(level_complete)
	color_rect.hide()
	v_box_gameover.hide()
	v_box_level_complete.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("charge"):
		if v_box_gameover.visible:
			get_tree().paused = false
			get_tree().reload_current_scene()
			player_died = false
		if v_box_level_complete.visible and player_died == false:
			GameManager.switch_scenes(Constants.GAME_SCENES.level2)


func level_complete() -> void:
	if player_died == false:
		get_tree().paused = true
		color_rect.show()
		v_box_level_complete.show()


func game_over() -> void:
	if player_died == false:
		get_tree().paused = true
		player_died = true
		color_rect.show()
		v_box_gameover.show()
	
