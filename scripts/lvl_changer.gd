extends Area2D

class_name lvlChanger

@export var lvl_to_change = ""


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		get_tree().change_scene_to_file(lvl_to_change)
