extends Node

@onready var bgm_player:AudioStreamPlayer2D =  $bgm
var leve2 = preload("res://scenes/level_2.tscn")
func _ready() -> void:
	bgm_player.play()

func to_level2():
	$".".add_child(leve2.instantiate())
	$LevelTransition.queue_free()
	remove_child($LevelTransition)
