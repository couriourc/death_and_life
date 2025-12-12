extends Node
# 静态变量保存单例实例	
static var instance: Node = null
# Called when the node enters the scene tree for the first time.
@onready var bgm_player:AudioStreamPlayer2D = $bgm
var CURSOR_ARROW = load("res://images/cursor/ink/working_page_01.png")

func play_bgm():
	bgm_player.play()
	

func _ready() -> void:
	if instance != null:
		queue_free()
		return
	instance = self
	Input.set_custom_mouse_cursor(CURSOR_ARROW,Input.CURSOR_ARROW)

func _exit_tree():
	# 节点被销毁时清空实例引用
	if instance == self:
		instance = null
