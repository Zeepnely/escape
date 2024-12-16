extends Area3D


@onready var camera = $Camera3D
@onready var initial_deg = camera.rotation_degrees

@export var trauma_reduction_rate = 1
@export var noise : FastNoiseLite
@export var noise_speed = 60
@export var max_x = 10
@export var max_y = 10
@export var max_z = 5
@export var is_active = true

var trauma = 0

var time = 0

var wantfov = 0

func _ready() -> void:
	pass

func _process(delta):
	if camera.current == true:
		
		trauma = 0
		wantfov = 0
		camera.fov = wantfov
		
		trauma = lerpf(trauma, 0, trauma_reduction_rate * delta)
		
		time += delta
		
		camera.rotation_degrees.x = initial_deg.x + max_x * (trauma * trauma) * get_noise_from_seed(0)
		camera.rotation_degrees.y = initial_deg.y + max_y * (trauma * trauma) * get_noise_from_seed(1)
		camera.rotation_degrees.z = initial_deg.z + max_z * (trauma * trauma) * get_noise_from_seed(2)
		
		trauma = trauma


func add_trauma(trauma_amount):
	trauma = clamp(trauma + trauma_amount, 0, 1)
	


func get_noise_from_seed(_seed):
	noise.seed = _seed
	return noise.get_noise_1d(time * noise_speed)


func on_change_camara():
	if is_active == true:
		camera.current = true
	else:
		camera.current = false
	
