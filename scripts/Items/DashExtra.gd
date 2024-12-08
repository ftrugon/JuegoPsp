extends InventoryItem

class_name dash_extra

func aplicar(stats: PlayerStats):
	stats.max_dashes += 1 
	stats.max_dash_coldown -= Atributos_constantes.max_dash_coldown / 2
