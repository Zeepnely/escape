extends Node

signal inventory_update
signal deselect
signal part_change

var max_stack_size := 100


var picked_up_item
var selected_item
var selected_inventory: int
var selected_inventory_icon


var temphold_texture

var temp_save_quantity: int
var to_much_to_handel := false

func _ready() -> void:
	inventory_update.emit()

func unnasighn_inventory(item, inventory: robotInventory):
	for i in range(inventory.inventory.size()):
		if inventory.inventory[i] != null and inventory.inventory[i]["type"] == item["type"] and inventory.inventory[i]["effect"] == item["effect"] and inventory.inventory[i]["name"] == item["name"]:
			inventory.inventory[i] = null
			inventory_update.emit()
			return true
	return false



func add_item(item, inventory: robotInventory):
	for i in range(inventory.inventory.size()):
		if inventory.inventory[i] != null and inventory.inventory[i]["type"] == item["type"] and inventory.inventory[i]["effect"] == item["effect"] and inventory.inventory[i]["name"] == item["name"] and inventory.inventory[i]["stack_size"] >= (inventory.inventory[i]["quantity"] + item["quantity"]):
			inventory.inventory[i]["quantity"] += item["quantity"]
			inventory_update.emit()
			return true
		elif inventory.inventory[i] == null:
			inventory.inventory[i] = item
			inventory_update.emit()
			return true
	return false



func remove_item(item, inventory: robotInventory):
	for i in range(inventory.inventory.size()):
		if inventory.inventory[i] != null and inventory.inventory[i]["type"] == item["type"] and inventory.inventory[i]["effect"] == item["effect"] and inventory.inventory[i]["name"] == item["name"]:
			inventory.inventory[i]["quantity"] -= 1
			if inventory.inventory[i]["quantity"] <= 0:
				inventory.inventory[i] = null
				inventory_update.emit()
				return true
			inventory_update.emit()
	return false

func drop_item(itemdata):
	var item_sceen = load(itemdata["self"]).instantiate()
	item_sceen.global_position = get_tree().get_current_scene().hand.global_position
	get_tree().get_current_scene().curent_world.add_child(item_sceen)
	item_sceen.global_position.y = get_tree().get_current_scene().player.global_position.y

func select_item(item):
	if selected_item == item:
		selected_item = null
	else:
		selected_item = item

func update_inventory_size():
	inventory_update.emit()
