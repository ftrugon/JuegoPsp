# main_scene.gd
extends Node

class_name Inventory

var items: Array = []
var stats_manager: PlayerStatsManager

func _ready() -> void:

	stats_manager = get_parent().estadisticas


func add_item(item: Item):
	items.append(item)

func remove_item(item:Item):
	items.erase(item)


func apply_items(itemsStats:PlayerStats):
	
	for item in items:
		item.aplicar(itemsStats)
