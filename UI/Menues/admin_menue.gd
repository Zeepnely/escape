extends Control

@onready var player = get_tree().get_current_scene().player
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()


func close():
	hide()
	


func open():
	show()

func _on_button_pressed() -> void:
	var names := ["Alice", "Bob", "Charlie", "David", "Henry", "Benzo"]
	var lastnames := ["caloke", "Jenson", "gonzolas", "Benimaru"]
	var robot = get_tree().get_current_scene().add_sceen_to(get_tree().get_current_scene().scenes_to_load["robot player"], get_tree().get_current_scene().curent_world)
	robot.global_position = player.hand.global_position
	robot.robot_name = names[int((randf() * 6))]
	robot.robot_name = lastnames[int((randf() * 4))]
