extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	show()
	$MarginContainer2.hide()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	$Hud.on_main_menue = true


func _on_quit_pressed():
	get_tree().quit()


func _on_options_pressed():
	get_parent().hud.open_the_menue("OptionsMenu")


func _on_play_pressed():
	#$MarginContainer.hide()
	#$MarginContainer2.show()
	get_parent().start()
