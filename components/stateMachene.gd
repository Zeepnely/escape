class_name stateMachene

extends Node


@export var curent_state : state
@export var this_thing : CharacterBody3D
var states : Dictionary = {}


func _ready():
	for i in get_children():
		if i is state:
			states[i.name] = i
			i.transition.connect(on_child_transition)
	await owner.ready
	curent_state.enter()
	


func _process(delta):
	curent_state.update(delta)
	

func _physics_process(delta):
	curent_state.physics_update(delta)
	

func on_child_transition(new_state_name : StringName):
	var new_state = states.get(new_state_name)
	if new_state != null:
		if new_state != curent_state:
			curent_state.exit()
			new_state.enter()
			curent_state = new_state
	else:
		pass
	
