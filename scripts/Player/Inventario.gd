# main_scene.gd
"""
extends Node

class_name Inventory

@export var items: Array = [InventoryItem]
var stats_manager: PlayerStatsManager

func _ready() -> void:
	stats_manager = get_parent().estadisticas


func add_item(item: InventoryItem):
	stats_manager.itemsStats.reiniciar_stats()
	items.append(item)
	apply_items(stats_manager.itemsStats)

func remove_item(item:InventoryItem):
	items.erase(item)
	stats_manager.itemsStats.reiniciar_stats()
	apply_items(stats_manager.itemsStats)


func apply_items(itemsStats:PlayerStats):
	
	for item in items:
		item.aplicar(itemsStats)
"""


extends Node2D

class_name Inventory

@export var items: Array[InventoryItem]
var stats_manager: PlayerStatsManager


func _ready() -> void:
	stats_manager = get_parent().estadisticas
	apply_items(stats_manager.itemsStats)



func apply_items(itemsStats:PlayerStats):
	
	for item in items:
		item.aplicar(itemsStats)
