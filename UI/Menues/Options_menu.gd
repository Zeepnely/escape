extends Control




# Called when the node enters the scene tree for the first time.
func _ready():
	get_saved_data()
	hide()
	create_action_list()
	master_vol.value = SavingScript.read_prefrances("main_bus")
	music_vol.value = SavingScript.read_prefrances("music_bus")
	sfx_vol.value = SavingScript.read_prefrances("sfx_bus")
	fullscreen = SavingScript.read_prefrances("fullscreen")
	if fullscreen:
		$TabContainer/Graphics/MarginContainer/VBoxContainer/HBoxContainer/CheckBox.button_pressed = true
	handle_fulscreen()


@onready var Input_button_scene = preload("res://UI/inputButton.tscn")
@onready var Action_list = $TabContainer/Controlls/MarginContainer/VBoxContainer/ScrollContainer/action_list
@onready var master_vol = $TabContainer/audio/MarginContainer/VBoxContainer/HBoxContainer/master
@onready var music_vol = $TabContainer/audio/MarginContainer/VBoxContainer/HBoxContainer2/Music
@onready var sfx_vol = $TabContainer/audio/MarginContainer/VBoxContainer/HBoxContainer3/SFX
@onready var diologe_vol = $TabContainer/audio/MarginContainer/VBoxContainer/HBoxContainer4/diologe

var master_bus_index = AudioServer.get_bus_index("Master")
var music_bus_index = AudioServer.get_bus_index("music")
var sfx_bus_index = AudioServer.get_bus_index("soundfx")
var fullscreen := false

var is_remaping = false
var action_to_remap = null
var remapping_button = null
var actionsMap = {"w" : "Forword",
"a" : "left",
"d" : "right",
"s" : "backword",
"jump" : "Jump",
"shift" : "Leg ability 1",
"cntr" : "Leg ability 2",
}

var temp_action_map: Dictionary


func create_action_list():
	for item in Action_list.get_children():
		item.queue_free()
		
	for action in actionsMap:
		var button = Input_button_scene.instantiate()
		var action_lable = button.find_child("action")
		var input_lable = button.find_child("input")
		action_lable.text = actionsMap[action]
		var events = InputMap.action_get_events(action)
		if events.size() > 0:
			input_lable.text = events[0].as_text().trim_suffix(" (Physical)")
		else:
			input_lable.text = ""
		Action_list.add_child(button)
		button.pressed.connect(_on_input_button_pressed.bind(button, action))

func _on_input_button_pressed(button, action):
	if !is_remaping:
		is_remaping = true
		action_to_remap = action
		remapping_button = button
		button.find_child("input").text = "Press key to rebind"
func open():
	show()

	
func close():
	hide()
	
func _input(event):
	if is_remaping:
		if (
			event is InputEventKey ||
			(event is InputEventMouseButton && event.pressed)
		):
			InputMap.action_erase_events(action_to_remap)
			InputMap.action_add_event(action_to_remap, event)
			send_save_data(action_to_remap, event)
			_update_action_list(remapping_button, event)
			
			
			
			is_remaping = false
			action_to_remap = null
			remapping_button = null
			accept_event()

func _update_action_list(button, event):
	button.find_child("input").text = event.as_text().trim_suffix(" (Physical)")


func _on_rester_pressed():
	InputMap.load_from_project_settings()
	temp_action_map.clear()
	SavingScript.save_prefrences(temp_action_map, "key_bind")
	create_action_list()


func send_save_data(action, event):
	if temp_action_map.has(action):
		temp_action_map[action] = event
	else:
		temp_action_map[action] = event
	SavingScript.save_prefrences(temp_action_map, "key_bind")


func get_saved_data():
	if SavingScript.read_prefrances("key_bind"):
		temp_action_map = SavingScript.read_prefrances("key_bind")
		for u in temp_action_map:
			InputMap.action_erase_events(u)
			InputMap.action_add_event(u, temp_action_map[u])
	else:
		return false




func _on_master_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(master_bus_index, linear_to_db(value))
	SavingScript.save_prefrences(value, "main_bus")


func _on_music_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(music_bus_index, linear_to_db(value))
	SavingScript.save_prefrences(value, "music_bus")


func _on_sfx_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(sfx_bus_index, linear_to_db(value))
	SavingScript.save_prefrences(value, "sfx_bus")


func _on_check_box_toggled(toggled_on: bool) -> void:
	if toggled_on:
		fullscreen = true
		handle_fulscreen()
		SavingScript.save_prefrences(true, "fullscreen")
	else:
		fullscreen = false
		handle_fulscreen()
		SavingScript.save_prefrences(false, "fullscreen")


func handle_fulscreen():
	if fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
