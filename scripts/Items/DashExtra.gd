# salto_extra.gd
class_name DashExtra extends Item

func _init():
	nombre = "Diarrea continua"
	desc = "Notas como se divide"
	efecto = "Dash extra!"

func aplicar(stats:PlayerStats):
	stats.max_dashes += 1
	stats.dash_force = stats.dash_force  * 0.80
