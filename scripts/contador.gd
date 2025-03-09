extends Control

var puede_pasar_tiempo = false
var tiempo_actual = 0.0
var label

func _ready() -> void:
	label = $CanvasLayer/Label

func _process(delta: float) -> void:
	if puede_pasar_tiempo == true:
		tiempo_actual += delta
	
	label.text = str("%.4f" % tiempo_actual)
