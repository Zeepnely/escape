class_name runningState
extends PlayerMovementState

@onready var player = get_parent().get_parent()


func enter():
	pass


func update(delta):
	var input_dir = Input.get_vector("a", "d", "w", "s")
	var direction = (player.body.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	player.velocity.x = lerp(player.velocity.x, direction.x * 6, delta * 20)
	player.velocity.z = lerp(player.velocity.z, direction.z * 6, delta * 20)
	
	if not direction:
		player.velocity.x = lerp(player.velocity.x, direction.x * 6, delta * 10)
		player.velocity.z = lerp(player.velocity.z, direction.z * 6, delta * 10)
	
	
	
	if Input.is_action_pressed("jump"):
		if player.is_on_floor():
			transition.emit("jumpShip")
				
	if player.velocity.length() < .001:
		transition.emit("idleShip")
	
	if !Input.is_action_pressed("shift"):
		transition.emit("shipplayerwalkingState")
		
	if !player.is_on_floor():
		if player.velocity.y <= 0:
			transition.emit("FallingShip")
		else:
			transition.emit("goingUpShip")
