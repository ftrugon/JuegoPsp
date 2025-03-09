extends Control

# Ejemplo de datos traídos de la base de datos
var datos = []
var item_list

@onready var http_request = $HTTPRequest
@onready var text_edit = $TextEdit

func enviar_datos():
	var url = "https://psp-api-wr3i.onrender.com/puntuacion"  # URL de la API
	var headers = ["Content-Type: application/json"]  # Cabecera para JSON
	var datos = { 
		"username": text_edit.text, 
		"time": Contador.tiempo_actual
	}
	
	var error = http_request.request(
		url, 
		headers, 
		HTTPClient.METHOD_POST, 
		JSON.stringify(datos)
	)
	
	if error != OK:
		print("Error al enviar la solicitud: ", error)

func _ready() -> void:
	Contador.puede_pasar_tiempo = false
	item_list = $ItemList
	mostrar_datos_en_itemlist()
	var url = "https://psp-api-wr3i.onrender.com/puntuacion"
	var error = http_request.request(url)
	if error != OK:
		print("Error al enviar la solicitud: ", error)

func mostrar_datos_en_itemlist():
	item_list.clear()  # Limpia la lista antes de llenarla
	
	for dato in datos:
		# Muestra solo el username y el tiempo formateado
		var texto = "%s - %.4f" % [dato["username"], dato["time"]]
		item_list.add_item(texto)

func comparar_tiempos(a, b) -> bool:
	return a["time"] < b["time"]

func _on_exit_button_down() -> void:
	get_tree().quit()

func _on_restart_button_down() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/level_1.tscn")

func _on_http_request_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	if response_code == 200:
		datos = JSON.parse_string(body.get_string_from_utf8())
		mostrar_datos_en_itemlist()
	elif response_code == 201:
		var url = "https://psp-api-wr3i.onrender.com/puntuacion"
		var error = http_request.request(url)
		if error != OK:
			print("Error al enviar la solicitud: ", error)
	else:
		print("Error en la respuesta: Código ", response_code)
	
	


func _on_button_pressed() -> void:
	enviar_datos()
