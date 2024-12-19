extends Node3D

@export var camara: Camera3D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready() -> void:
	camara.current = false

func start_cutscene(cutscene : String):
	camara.current = true
