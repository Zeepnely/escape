extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

@export var scene: String
@export var hand: Node3D
@export var camara: Node3D

@onready var body = $body
@onready var head = $body/head


var max_step_hight = 1
var snapped_to_stairs_last_frame := false
var last_frame_was_on_floor = -INF





func _ready() -> void:
	get_tree().get_current_scene().hand = hand

func _physics_process(delta: float) -> void:
	if is_on_floor():
		last_frame_was_on_floor = Engine.get_physics_frames()
	if not _snap_up_stairs_check(delta):
		move_and_slide()
		snap_down_to_stairs_check()
		


func load_game(saved_data: playerSave):
	if saved_data.scene == scene:
		head.rotation = saved_data.head_rot
		global_position = saved_data.position
		global_rotation = saved_data.rotation
		velocity = saved_data.velocity
	



func on_save_game(saved_data: Array[savedData]):
	if get_parent() == get_parent().get_parent().curent_world:
		var my_data = playerSave.new()
		my_data.head_rot = head.rotation
		my_data.position = global_position
		my_data.rotation = global_rotation
		my_data.velocity = velocity
		my_data.scene = scene
		saved_data.append(my_data)


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		body.rotate_y(-event.relative.x * .01)
		head.rotate_x(-event.relative.y * .01)


func is_serface_too_steep(normal : Vector3) -> bool:
	return normal.angle_to(Vector3.UP) > self.floor_max_angle
	


func _run_body_test_motion(from : Transform3D, motion : Vector3, result = null) -> bool:
	if not result: result = PhysicsTestMotionResult3D.new()
	var params = PhysicsTestMotionParameters3D.new()
	params.from = from
	params.motion = motion
	return PhysicsServer3D.body_test_motion(self.get_rid(), params, result)


func _snap_up_stairs_check(delta) -> bool:
	if not is_on_floor() and not snapped_to_stairs_last_frame: return false
	# Don't snap stairs if trying to jump, also no need to check for stairs ahead if not moving
	if self.velocity.y > 0 or (self.velocity * Vector3(1,0,1)).length() == 0: return false
	var expected_move_motion = self.velocity * Vector3(1,0,1) * delta
	var step_pos_with_clearance = self.global_transform.translated(expected_move_motion + Vector3(0, max_step_hight * 2, 0))
	# Run a body_test_motion slightly above the pos we expect to move to, towards the floor.
	#  We give some clearance above to ensure there's ample room for the player.
	#  If it hits a step <= MAX_STEP_HEIGHT, we can teleport the player on top of the step
	#  along with their intended motion forward.
	var down_check_result = KinematicCollision3D.new()
	if (self.test_move(step_pos_with_clearance, Vector3(0,-max_step_hight*2,0), down_check_result)
	and (down_check_result.get_collider().is_class("StaticBody3D") or down_check_result.get_collider().is_class("CSGShape3D"))):
		var step_height = ((step_pos_with_clearance.origin + down_check_result.get_travel()) - self.global_position).y
		# Note I put the step_height <= 0.01 in just because I noticed it prevented some physics glitchiness
		# 0.02 was found with trial and error. Too much and sometimes get stuck on a stair. Too little and can jitter if running into a ceiling.
		# The normal character controller (both jolt & default) seems to be able to handled steps up of 0.1 anyway
		if step_height > max_step_hight or step_height <= 0.01 or (down_check_result.get_position() - self.global_position).y > max_step_hight: return false
		%oneinfront.global_position = down_check_result.get_position() + Vector3(0,max_step_hight,0) + expected_move_motion.normalized() * 0.1
		%oneinfront.force_raycast_update()
		if %oneinfront.is_colliding() and not is_serface_too_steep(%oneinfront.get_collision_normal()):
			self.global_position = step_pos_with_clearance.origin + down_check_result.get_travel()
			apply_floor_snap()
			snapped_to_stairs_last_frame = true
			return true
	return false

func snap_down_to_stairs_check():
	var did_snap := false
	var floor_below : bool = %oneDown.is_colliding() and not is_serface_too_steep(%oneDown.get_collision_normal())
	var was_on_floor_last_frame = Engine.get_physics_frames() - last_frame_was_on_floor == 1
	if not is_on_floor() and velocity.y <= 0 and (was_on_floor_last_frame or snapped_to_stairs_last_frame) and floor_below:
		var body_test_result = PhysicsTestMotionResult3D.new()
		if _run_body_test_motion(self.global_transform, Vector3(0, -max_step_hight, 0), body_test_result):
			var translte_y = body_test_result.get_travel().y
			self.position.y += translte_y
			apply_floor_snap()
			did_snap = true
	
	snapped_to_stairs_last_frame = did_snap


func _process(delta):
	
	if get_interactable_component_at_shapecast():
		get_interactable_component_at_shapecast().hover_curser(self)
		if Input.is_action_just_pressed("primary arm 2"):
			get_interactable_component_at_shapecast().got_intercted(self)
		if Input.is_action_just_pressed("interact"):
			get_interactable_component_at_shapecast().got_intercted(self)

func get_interactable_component_at_shapecast() -> InteractableComponenent:
	for i in %interactionShapeCast3D.get_collision_count():
		if i > 0 and %interactionShapeCast3D.get_collider(0) != $".":
			return null
		if %interactionShapeCast3D.get_collider(i).get_node_or_null("InteractableComponenent") is InteractableComponenent:
			return %interactionShapeCast3D.get_collider(i).get_node_or_null("InteractableComponenent")
	return null
