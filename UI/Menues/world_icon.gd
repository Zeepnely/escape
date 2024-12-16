extends Control

var plannet : String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$MarginContainer/Button.text = plannet


func _on_button_pressed() -> void:
	get_parent().get_parent().get_parent().world_pressed(plannet)
