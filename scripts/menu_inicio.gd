extends Control

class_name Menu_principal

func _on_inicar_partida_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/level_1.tscn")
	Contador.puede_pasar_tiempo = true

func _on_salir_pressed() -> void:
	get_tree().quit()
