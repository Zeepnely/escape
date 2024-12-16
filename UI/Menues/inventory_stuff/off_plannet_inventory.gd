extends Control


@onready var item_container := $MarginContainer/VBoxContainer
@onready var ship_item_container := $MarginContainer2/VBoxContainer
@onready var inventory_slot := preload("res://UI/Menues/inventory_stuff/inventory_item.tscn")
@export var show_drop_use: bool
@onready var player = get_tree().get_current_scene().player

var in_menue_mode := false


func _ready() -> void:
	PlayerInventory.inventory_update.connect(_on_inventory_update)
	_on_inventory_update()





func _on_inventory_update():
	clear_inventory()
	if player != null:
		for item in player.inventory.inventory:
			var slot = inventory_slot.instantiate()
			if show_drop_use == true:
				slot.hide_things = true
			item_container.add_child(slot)
			if item != null:
				slot.set_item(item)
			else:
				slot.set_empty()




func clear_inventory():
	while item_container.get_child_count() > 0:
		var child := item_container.get_child(0)
		item_container.remove_child(child)
		child.queue_free()
