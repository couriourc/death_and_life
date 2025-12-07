extends Node

@export var move_speed: float = 500.0  # 移动速度（像素/秒）
@export var loop: bool = true  # 是否循环移动
@export var progress:float = 0:
	set(value):
		progress = value
		move_me(value)

@onready var line_2d:Line2D = $path
@onready var move_sprite = $me # 要移动的精灵

var path_points: PackedVector2Array  # 线条的所有顶点
var current_segment: int = 0  # 当前在第几个线段（从0开始）
var segment_progress: float = 0.0  # 当前线段的进度（0→1）
var total_length = 0.0:
	get():
		var value = 0
		for i in range(path_points.size()-1):
			value += path_points[i].distance_to(path_points[i+1])
		return value
		
func _ready() -> void:
	path_points = line_2d.points
	assert(path_points.size() > 2)
	# 初始化精灵到线条起点
	move_sprite.global_position= line_2d.to_global(path_points[0])

func move_me(progress: float): 
	var traveled =0.
	var target_dist = (progress/100)*total_length
	print(progress)
	for i in range(path_points.size() - 1):
		var seg_len = path_points[i].distance_to(path_points[i+1])
		var direction = (path_points[i+1] - path_points[i]).normalized()
		move_sprite.rotation = acos(direction.x*direction.y/sqrt(direction.length()))
		if traveled + seg_len >= target_dist:
			var seg_progress = (target_dist - traveled) / seg_len
			move_sprite.global_position = line_2d.to_global(path_points[i].lerp(path_points[i+1], seg_progress))
			return 
		traveled += seg_len
		
func start_move():
	var total_time = total_length / move_speed
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_method( move_me ,0.0,1.0,total_time)
