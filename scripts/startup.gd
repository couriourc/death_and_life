extends Node

@onready var main_tscn = "res://main.tscn"
@onready var splash_screen = $"."  # 替换为你的Control节点路径

func _on_animation_finished(_anim_name):
	splash_screen.grab_focus()  # 主动获取键盘焦点



func _on_main_title_gui_input(event: InputEvent) -> void:
	if event.is_action("ui_accept"):
		SceneManager.change_scene(main_tscn)
	if event is InputEvent:
		if event.is_match(event,MOUSE_BUTTON_LEFT) and event.is_pressed():
			SceneManager.change_scene(main_tscn)
