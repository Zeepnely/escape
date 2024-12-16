class_name goingUpShip
extends PlayerMovementState

@onready var player = get_parent().get_parent()

func enter():
	pass



func update(delta):
	
	
	if !player.is_on_floor():
		if player.velocity.y <= 0:
			transition.emit("FallingState")
	else:
		transition.emit("idleShip")


func physics_update(delta):
	var input_dir = Input.get_vector("a", "d", "w", "s")
	var direction = (player.body.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	player.velocity.x = lerp(player.velocity.x, direction.x * 4, delta * 2)
	player.velocity.z = lerp(player.velocity.z, direction.z * 4, delta * 2)
	
	player.velocity.y -= 9 * delta
