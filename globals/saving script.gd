extends Node

func check_for_a_world(world):
	if world.world_scene == get_tree().get_current_scene().curent_world.world_scene:
		return true
	else:
		return false

func save_data():
	pass
'	var id := 0
	var save_file:savedWorld
	if get_tree().get_current_scene().curent_world.name == "Ship":
		save_file = SavedShip.new()
		save_file.worlds_landed = PlannetInfo.plannets_viseted
	else:
		save_file = savedWorld.new()
	save_file.world_name = get_tree().get_current_scene().curent_world.name
	var saved_data: Array[savedData] = save_file.saved_data
	get_tree().call_group("SaveDataNeed", "on_save_game", saved_data)
	if save_file is savedWorld:
		print(PlayerToPlaces.players)
		for i in PlayerToPlaces.players:
			if i == null:
				PlayerToPlaces.players.erase(i)
			else:
				save_file.things_to_accses.append(i.robot_name)
	for i in saved_data:
		i.id = id
		id += 1
	ResourceSaver.save(save_file, "user://saves//" + str(get_tree().get_current_scene().curent_world.name) + "_save.tres")'


func load_data():
	pass
	'if !DirAccess.dir_exists_absolute("user://saves/"):
		DirAccess.open("user://").make_dir("saves")
	
	var saved_game: savedWorld = load("user://saves//" + str(get_tree().get_current_scene().curent_world.name) + "_save.tres") as savedWorld
	if saved_game != null:
		if saved_game is SavedShip:
			PlannetInfo.plannets_viseted = saved_game.worlds_landed
		for i in saved_game.saved_data:
			get_tree().call_group("SaveDataNeed", "on_load_game", i)
	else:
		if get_tree().get_current_scene().curent_world.name == "Ship":
			var player_save = playerSave.new()
			player_save.scene = "res://Players/ship_player/ship_player.tscn"
			player_save.id = 0
			player_save.position = get_tree().get_current_scene().curent_world.global_position
			
			saved_game = SavedShip.new()
			PlannetInfo.plannets_viseted.append("WaterWorld")
			saved_game.saved_data.append(player_save)
			for i in saved_game.saved_data:
				get_tree().call_group("SaveDataNeed", "on_load_game", i)'


func save_prefrences(dictionary, location):
	var prefrances: prefranceSave = prefranceSave.new()
	match location:
		"key_bind":
			prefrances.key_binds = dictionary
		"main_bus":
			prefrances.main_bus = dictionary
		"music_bus":
			prefrances.music_bus = dictionary
		"sfx_bus":
			prefrances.sfx_bus = dictionary
		"fullscreen":
			prefrances.fullscreen = dictionary
	if !DirAccess.dir_exists_absolute("user://saves/"):
		DirAccess.open("user://").make_dir("saves")
	ResourceSaver.save(prefrances, "user://saves//prefrances.tres")


func read_prefrances(location):
	if !DirAccess.dir_exists_absolute("user://saves/"):
		DirAccess.open("user://").make_dir("saves")
		return false
	if !FileAccess.file_exists("user://saves//prefrances.tres"):
		return false
	var prefrances: prefranceSave = load("user://saves//prefrances.tres")
	match location:
		"key_bind":
			return prefrances.key_binds
		"main_bus":
			return prefrances.main_bus
		"music_bus":
			return prefrances.music_bus
		"sfx_bus":
			return prefrances.sfx_bus
		"fullscreen":
			return prefrances.fullscreen
