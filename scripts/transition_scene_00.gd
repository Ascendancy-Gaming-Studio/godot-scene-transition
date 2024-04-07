extends Control

@export var target_scene: PackedScene

func _on_button_change_scene_pressed() -> void:
	if not target_scene.can_instantiate():
		return
		
	get_tree().change_scene_to_packed(target_scene)
