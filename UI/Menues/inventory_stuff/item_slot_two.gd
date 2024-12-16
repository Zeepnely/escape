extends Control

var stored_item
@export var selected_collor: Color
@export var unselected_collor: Color
@export var slot_filter: String
@export var amount_filter: int
@export var slot_id: int


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	PlayerInventory.deselect.connect(deselect)
	$MarginContainer2.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_margin_container_focus_entered() -> void:
	$MarginContainer2.show()


func _on_margin_container_focus_exited() -> void:
	$MarginContainer2.hide()


func clear_item():
	deselect()
	$PanelContainer/MarginContainer/PanelContainer/TextureRect.texture = null
	$PanelContainer/MarginContainer/PanelContainer2/Label.text = ""
	$MarginContainer2/VBoxContainer/Label.text = ""
	$MarginContainer2/VBoxContainer/Label3.text = ""
	$MarginContainer2/VBoxContainer/Label2.text = ""

func set_item(item):
	stored_item = item
	$PanelContainer/MarginContainer/PanelContainer/TextureRect.texture = item["texture"]
	$PanelContainer/MarginContainer/PanelContainer2/Label.text = str(item["quantity"])
	$MarginContainer2/VBoxContainer/Label.text = item["name"]
	$MarginContainer2/VBoxContainer/Label3.text = item["disc"]

func select():
	$PanelContainer/ColorRect.color = selected_collor


func deselect():
	$PanelContainer/ColorRect.color = unselected_collor



func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("primary arm 1"):
		PlayerInventory.deselect.emit()
		if PlayerInventory.selected_item != null:
			PlayerInventory.control_parts(PlayerInventory.selected_item, slot_id, self)
			select()
			PlayerInventory.selected_inventory_icon = self
