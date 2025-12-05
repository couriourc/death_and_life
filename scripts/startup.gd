extends Control

@onready var main_tscn = "res://main.tscn"

func _on_animation_finished(anim_name):
	get_tree().change_scene_to_file(main_tscn)
	
	
func _ready() -> void:
	pass
