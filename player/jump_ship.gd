class_name jumpShip
extends PlayerMovementState

@onready var player = get_parent().get_parent()

func enter():
	pass

func update(delta):
	player.velocity.y += 4
	
	if player.velocity.y < 0:
		transition.emit("FallingShip")
	else:
		transition.emit("goingUpShip")
