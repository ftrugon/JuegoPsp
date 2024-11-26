# salto_extra.gd
class_name SaltoExtra extends Item

func _init():
	nombre = "Extra de gasolina"
	efecto = "Salto extra!"

func aplicar(stats:PlayerStats):
	stats.max_jumps += 1
