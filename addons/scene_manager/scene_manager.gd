extends Node

func exit_process():
	get_tree().quit(0)
	
func change_scene(scene:String):
	get_tree().change_scene_to_file(scene)
