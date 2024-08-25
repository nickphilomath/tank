extends CharacterBody3D

@onready var camera = $Camera3D

const SPEED = 500
const ROTATE_SPEED = 60
const CAM_ROTATE_SPEED = 0.003

var cam_rotation_y = 0  # radian
var cam_rotation_x = 0  # radian
var cam_distance = 7 # unit
const min_cam_distance = 1
const max_cam_distance = 10


#func _ready():
	#Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			cam_distance -= 1
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			cam_distance += 1
			
	elif event is InputEventMouseMotion:
		cam_rotation_y += CAM_ROTATE_SPEED * -event.relative.x
		cam_rotation_x += CAM_ROTATE_SPEED * -event.relative.y


func _physics_process(delta):
	## rotate around y and then x axis
	#camera.position = Vector3(
		#cam_distance * sin(cam_rotation_y),
		#cam_distance * cos(cam_rotation_y) * sin(cam_rotation_x),
		#cam_distance * cos(cam_rotation_y) * cos(cam_rotation_x)
	#)
	# rotate around x and then y axis
	camera.position = Vector3(
		cam_distance * cos(cam_rotation_x) * sin(cam_rotation_y),
		-cam_distance * sin(cam_rotation_x),
		cam_distance * cos(cam_rotation_x) * cos(cam_rotation_y)
	)
	camera.look_at(position)
	
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Get the input direction and handle the movement/deceleration.
	var input_move   = Input.get_axis("up", "down")
	var input_rotate = Input.get_axis("left", "right")
	if input_rotate:
		rotation_degrees.y += -input_rotate * ROTATE_SPEED * delta
	if input_move:
		velocity.z = input_move * SPEED * delta
	#var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	#if direction:
		#velocity.x = direction.x * SPEED
		#velocity.z = direction.z * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
		#velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	
	
func _process(delta):
	if Input.is_key_pressed(KEY_CTRL):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		
