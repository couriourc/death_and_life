extends Node
# 静态变量保存单例实例	
static var instance: Node = null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if instance != null:
		queue_free()
		return
	instance = self

func _exit_tree():
	# 节点被销毁时清空实例引用
	if instance == self:
		instance = null
