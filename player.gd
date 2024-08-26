extends VehicleBody3D

#@onready var camera = $Camera3D

const SPEED = 300
const ROTATE_SPEED = 100

const min_cam_distance = 1
const max_cam_distance = 10


#func _ready():
	#Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _physics_process(delta):
	# Add the gravity.
	#if not is_on_floor():
		#velocity += get_gravity() * delta

	# Get the input direction and handle the movement/deceleration.
	var input_move   = Input.get_axis("up", "down")
	var input_rotate = Input.get_axis("left", "right")
	if input_rotate:
		rotation_degrees.y += -input_rotate * ROTATE_SPEED * delta
	if input_move:
		apply_central_force(input_move * global_transform.basis.z * 1000)
		#velocity.z = input_move * SPEED * delta
	#var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	#if direction:
		#velocity.x = direction.x * SPEED
		#velocity.z = direction.z * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
		#velocity.z = move_toward(velocity.z, 0, SPEED)

	#move_and_slide()
	
	
func _process(delta):
	if Input.is_key_pressed(KEY_CTRL):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		
