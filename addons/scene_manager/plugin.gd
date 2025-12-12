@tool
extends EditorPlugin


func _enable_plugin() -> void:
	# Add autoloads here.
	pass


func _disable_plugin() -> void:
	# Remove autoloads here.
	pass


func _enter_tree() -> void:
	# Initialization of the plugin goes here.
	add_autoload_singleton("SceneManager", "res://addons/scene_manager/scene_manager.tscn")


func _exit_tree() -> void:
	# Clean-up of the plugin goes here.
	remove_autoload_singleton("SceneManager")
