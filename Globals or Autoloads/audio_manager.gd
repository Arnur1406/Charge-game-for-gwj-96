extends Node

enum SOUNDS {
	low, charge, death
}

var SOUNDS_DICTIONARY: Dictionary = {
	SOUNDS.low: preload("uid://bitsov85lh61o"),
	SOUNDS.charge: preload("uid://dujjb3yxiefdr"),
	SOUNDS.death: preload("uid://bdkk7wcrdtgr2")
}


func play_sound(audio_player: AudioStreamPlayer, sound: int) -> void:
	audio_player.stream = SOUNDS_DICTIONARY[sound]
	audio_player.play()
