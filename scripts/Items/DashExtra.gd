extends InventoryItem

class_name dash_extra

func aplicar(stats: PlayerStats):
	stats.max_dashes += 1  # Incrementa la salud del jugador
