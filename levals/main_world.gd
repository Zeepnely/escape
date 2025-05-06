extends Node3D

var rooms : Dictionary = {"spawn_room": "res://levals/start_area/spawn_room.tscn",
"main_menue" : "res://UI/Menues/main_menue.tscn",
"world_enviroment": "res://levals/enviroment.tscn"}

@export var player_scene: String
@export var hud: Control
@export var cutscene: Node3D


var player: CharacterBody3D
var hand: Node3D
var menue
var current_room: Node3D

func _ready() -> void:
	menue = add_scene(rooms["main_menue"],0)
	hud.on_main_menue = true
	

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("f"):
		cutscene.start_cutscene("gdgd")


func exit_game():
	remove_child(current_room)
	hud.on_main_menue = true
	add_child(menue)
	menue._ready()

func start():
	remove_child(menue)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	hud.on_main_menue = false
	add_scene(rooms["spawn_room"],-1)
	add_scene(rooms["world_enviroment"],-1)
	player = add_scene(player_scene,-1)
	player.position.y = -29.793
	player.position.x = 371.005
	player.position.z = 7.803
	
	
func add_scene(scene: String, pos: int) -> Node:
	var temp_scene = load(scene).instantiate()
	add_child(temp_scene)
	if pos <= 0:
		move_child(temp_scene, pos)
	return temp_scene
	
