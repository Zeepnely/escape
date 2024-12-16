extends Control


@onready var ship_item_container := $MarginContainer/VBoxContainer
@onready var inventory_slot := preload("res://UI/Menues/inventory_stuff/inventory_item.tscn")
@export var show_drop_use: bool

var in_menue_mode := false






func clear_inventory():
	while ship_item_container.get_child_count() > 0:
		var child := ship_item_container.get_child(0)
		ship_item_container.remove_child(child)
		child.queue_free()
