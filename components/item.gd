class_name item_component
extends Node

@export var item_name : String
@export var weight : float
@export var type : String
@export var effect : String
@export var world: String
@export var item_sceen: String
@export var discription: String
@export var icon: Texture
@export var stack_size: int

@onready var model = get_parent().get_children(0)


func get_colision():
	for i in get_parent().get_children():
		if i is CollisionShape3D:
			i.shape.custom_solver_bias = 0.9
		

func _ready() -> void:
	get_colision()

func pickup_item(pickerup):
	var item = {
		"quantity" : 1,
		"type" : type,
		"name" : item_name,
		"weight" : weight,
		"effect" : effect,
		"model" : model,
		"self" : item_sceen,
		"disc" : discription,
		"texture" : icon,
		"stack_size" : stack_size
	}
	PlayerInventory.add_item(item, pickerup.inventory)
	get_parent().queue_free()
