extends Area2D

class_name lvlChanger

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		
		var current_scene_file = get_tree().current_scene.scene_file_path
		var next_lvl_number = current_scene_file.to_int() +1
		var next_lvl = "res://scenes/levels/level_" + str(next_lvl_number) + ".tscn"
		
		get_tree().call_deferred("change_scene_to_file",next_lvl )
	
