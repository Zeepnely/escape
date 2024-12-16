class_name InteractableComponenent
extends Node

var charecters_hovering = {}


signal interacted


func got_intercted(playerthat):
	if get_tree().get_current_scene().somthing_picked_up:
		interacted.emit(playerthat)


func _process(delta):
	for charecter in charecters_hovering.keys():
		if Engine.get_process_frames() - charecters_hovering[charecter] > 1:
			charecters_hovering.erase(charecter)

func hover_curser(charecter : Node3D):
	if get_tree().get_current_scene().somthing_picked_up:
		charecters_hovering[charecter] = Engine.get_process_frames()
	
	

func get_charecters_hovering_by_current_camara() -> Node3D:
	for charecter in charecters_hovering.keys():
		var cur_cam = get_viewport().get_camera_3d() if get_viewport() else null
		if cur_cam in charecter.find_children("*", "Camera3D"):
			return charecter
	return null
	
