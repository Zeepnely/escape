extends Node3D

var rooms : Dictionary = {"spawn_room": "res://levals/start_area/spawn_room.tscn",
"main_menue" : "res://UI/Menues/main_menue.tscn",
"world_enviroment": "res://levals/enviroment.tscn"}

@export var player_scene: String
@export var hud: Control

var player: CharacterBody3D
var hand: Node3D
var menue
var current_room: Node3D

func _ready() -> void:
	menue = add_scene(rooms["main_menue"])
	



func exit_game():
	remove_child(current_room)
	add_child(menue)
	menue._ready()

func start():
	remove_child(menue)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	add_scene(rooms["spawn_room"])
	add_scene(rooms["world_enviroment"])
	player = add_scene(player_scene)
	player.position.y = -29.793
	player.position.x = 371.005
	player.position.z = 7.803
	
	
func add_scene(scene: String) -> Node:
	var temp_scene = load(scene).instantiate()
	add_child(temp_scene)
	return temp_scene
	
