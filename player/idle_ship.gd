class_name idleShip
extends PlayerMovementState

@onready var player = get_parent().get_parent()

func enter():
	pass

func update(delta):
	
	if Input.is_action_pressed("jump"):
		transition.emit("jumpShip")
			
				
				

	if player.is_on_floor() or player.snapped_to_stairs_last_frame:
		if abs(player.velocity.x) > .001 || abs(player.velocity.z) > .001 || Input.is_action_just_pressed("w")|| Input.is_action_just_pressed("a")|| Input.is_action_just_pressed("s")|| Input.is_action_just_pressed("d"):
			transition.emit("shipplayerwalkingState")
	else:
		if player.velocity.y < 0:
			transition.emit("FallingShip")
		else:
			transition.emit("goingUpShip")
