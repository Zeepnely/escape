extends Control




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()


func close():
	hide()


func open():
	PlayerInventory.inventory_update.emit()
	show()
