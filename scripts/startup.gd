extends Node

@onready var main_tscn = "res://main.tscn"
@onready var splash_screen = $"."  # 替换为你的Control节点路径

func _on_animation_finished(_anim_name):
	splash_screen.grab_focus()  # 主动获取键盘焦点
	await get_tree().create_timer(1.0).timeout
	SceneRoot.change_scene(main_tscn)
