extends Control

var stored_item = null
var hide_things: bool


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready() -> void:
	if hide_things == true:
		$MarginContainer/HBoxContainer/MarginContainer3/VBoxContainer/Button.hide()
		$MarginContainer/HBoxContainer/MarginContainer3/VBoxContainer/Button2.hide()

func inventory_opend():
	for i in get_tree().get_current_scene().hud.open_menues:
		if i  != "PlayerInventory":
			$MarginContainer/HBoxContainer/MarginContainer3/VBoxContainer/Button.hide()
			$MarginContainer/HBoxContainer/MarginContainer3/VBoxContainer/Button2.hide()


func set_item(item):
	stored_item = item
	$MarginContainer/HBoxContainer/MarginContainer/TextureRect.texture = item["texture"]
	$MarginContainer/HBoxContainer/MarginContainer2/VBoxContainer/MarginContainer/Label.text = item["name"]
	$MarginContainer/HBoxContainer/MarginContainer2/VBoxContainer/Label2.text = item["disc"]
	$MarginContainer/HBoxContainer/MarginContainer/num_items.text = str(item["quantity"])
	if item["effect"] == null:
		$MarginContainer/HBoxContainer/MarginContainer3/VBoxContainer/Button2.hide()

func set_empty():
	hide()


func _on_button_2_pressed() -> void:
	if stored_item != null:
		if stored_item["effect"] != null:
			match stored_item["effect"]:
				pass


func _on_button_pressed() -> void:
	if stored_item != null:
		PlayerInventory.drop_item(stored_item)
		PlayerInventory.remove_item(stored_item, get_tree().get_current_scene().player.inventory)





func _on_button_pressed5() -> void:
		PlayerInventory.select_item(stored_item)
		PlayerInventory.selected_inventory = 5
