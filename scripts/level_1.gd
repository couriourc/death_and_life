extends Node
# @export 
@export var text_to_type:String = "我 死在了25岁"
@export var total_duration: float = 2.  # 打完所有字的总时长（秒）
@export var ease_type: Tween.EaseType = Tween.EASE_IN_OUT  # 缓动类型（默认二次方缓入缓出）
@export var chars_per_second: int = 1  # 每秒显示的字符数
@export var target_char_list: Array[int] = [3, 8, 12] # 定义目标字符数列表
@export var type_sound: AudioStream  # 打字音效（在编辑器中赋值）
@export var need_play: bool = true
# @onready
@onready var label = $bg/center_level/title
@onready var audio_player = $AudioStreamPlayer2D  # 提前添加AudioStreamPlayer节点

# @var
var current_text: String = ""
var current_index: int = 0
var time_accumulator: float = 0.0
var tween: Tween  # 缓动控制器
var sound_played_dict:Dictionary;
# setter 
# 缓动进度（0=未开始，1=完成），由Tween自动更新
# 播放打字音效的封装函数
func play_typing_sound() -> void:
	if audio_player and type_sound:
		audio_player.stream = type_sound
		audio_player.play()  # 播放一次音效
		
var progress: float = 0.0:
	set(value):
		progress = value
		var char_count = floor(progress * text_to_type.length())
		if int(char_count) in target_char_list and not sound_played_dict.has(char_count):
			play_typing_sound()
			sound_played_dict[char_count] = true  # 用字典标记已播放的字符数
		label.text = text_to_type.substr(0,char_count)
		
func _ready():
	if not need_play:
		label.text = text_to_type
		return 
	label.text = ""
	start_typewrite()
	
func start_typewrite():
	if tween and tween.is_running():
		tween.kill()
	tween = create_tween()
	tween.set_ease(ease_type)
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_interval(2.5)
	tween.chain().tween_property(self,"progress",1.0,total_duration)
	tween.connect("finished",
	func ():
		AutoLoad.play_bgm()
		SceneRoot.change_scene("res://scenes/level_2.tscn")
	)
