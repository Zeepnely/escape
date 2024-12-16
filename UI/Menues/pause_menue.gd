extends Control
var is_paused = false



func _ready():
	close()

func open():
	get_tree().paused = true
	show()
	is_paused = true
	
func close():
	get_tree().paused = false
	hide()
	is_paused = false
	



func _on_play_pressed():
	get_tree().get_current_scene().hud.close_menues()


func _on_options_pressed():
	get_tree().get_current_scene().hud.open_the_menue("OptionsMenu")


func _on_main_menue_pressed():
	get_tree().paused = false
	SavingScript.save_data()
	hide()
	get_tree().get_current_scene().exit_game()
	
