class_name PlayerMovementState
extends state

var PLAYER : CharacterBody3D
var ANIMATIONS : AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	await owner.ready
	PLAYER = owner as CharacterBody3D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	pass
