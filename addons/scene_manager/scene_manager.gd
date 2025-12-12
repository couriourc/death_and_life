extends Node

var pre_scene: Node = null
var now_scene_idx: int = 0
var now_scene: Node = null
@export var level_sequence: Array[String] = [
	"res://scenes/level_1.tscn",
	"res://scenes/level_2.tscn"
]
# 静态变量保存单例实例	
static var instance: SceneRoot = null
@onready var stage: CanvasLayer = $stage
@onready var pre_stage: CanvasLayer = $pre_stage


func _ready():
	# 初始化单例
	if instance == null:
		instance = self
	else:
		queue_free()

# 修复：动画作用于旧场景节点（pre_scene）而非CanvasLayer
func slide():
	# 检查旧场景是否存在且挂载到pre_stage
	if not pre_scene or pre_scene.get_parent() != pre_stage:
		print("前置场景节点不存在/未挂载到pre_stage，跳过动画")
		return 
		
	# 重置旧场景的初始变换（避免继承之前的状态）
	
	# 创建补间动画（绑定到pre_scene，确保动画跟随节点）
	var tw = pre_scene.create_tween()
	tw.set_ease(Tween.EASE_IN_OUT)  # 自然的缓动效果
	tw.set_trans(Tween.TRANS_QUAD)  # 二次曲线过渡
	
	# 并行执行：向上移动200像素 + 缩放到0.5倍（时长0.5秒）
	tw.tween_property(pre_scene, "position", Vector2(0, -200), 1)  # 向上移（负值更符合视觉习惯）
	
	# 动画结束后清理旧场景
	tw.finished.connect(func():
		if pre_scene:
			print("移除前置场景")
			pre_scene.queue_free()
			pre_scene = null
	)

# 修复场景切换逻辑 + print_error拼写错误
func change_scene(scene: String):
	# 加载场景（增加空值检查）
	var level_packed = load(scene)
	if not level_packed:
		return
	
	var new_scene = level_packed.instantiate()
	if not new_scene:
		return
	
	# 1. 处理旧场景：移到pre_stage
	if now_scene:
		pre_scene = now_scene
		# 将旧场景重新挂载到pre_stage，重置其变换
		pre_scene.reparent(pre_stage, false)
	
	# 2. 挂载新场景到主舞台
	now_scene = new_scene
	stage.add_child(now_scene)
	
	# 3. 执行滑动动画（确保旧场景已挂载）
	if pre_scene:
		slide()

func exit_process():
	get_tree().quit(0)

# 按顺序切换下一关（可选）
func next_level():
	if now_scene_idx < level_sequence.size() - 1:
		now_scene_idx += 1
		change_scene(level_sequence[now_scene_idx])
	else:
		print("已是最后一关")
