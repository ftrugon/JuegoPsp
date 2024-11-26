# item.gd
class_name Item

# Definimos propiedades comunes a todos los ítems
var nombre: String
var desc: String
var efecto: String
var activo: bool = false
var costo: int = 1

# Método abstracto que debe ser implementado por las subclases
func aplicar(stats:PlayerStats):
	pass
