extends Control



func _on_exit_button_down() -> void:
	get_tree().quit()


func _on_restart_button_down() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/level_1.tscn")
