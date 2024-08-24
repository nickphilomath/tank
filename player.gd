extends CharacterBody3D

@onready var camera = $Camera3D

const SPEED = 500
const ROTATE_SPEED = 60
const CAM_ROTATE_SPEED = 0.003

var camera_rotation_y = 0  # radian
var camera_rotation_x = 0  # radian
var camera_distance = 10 # unit


#func _ready():
	#Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _unhandled_input(event):
	if event is InputEventMouseMotion:
		camera_rotation_y += CAM_ROTATE_SPEED * -event.relative.x
		camera_rotation_x += CAM_ROTATE_SPEED * -event.relative.y
	
		## rotate around y and then x axis
		#camera.position = Vector3(
			#camera_distance * sin(camera_rotation_y),
			#camera_distance * cos(camera_rotation_y) * sin(camera_rotation_x),
			#camera_distance * cos(camera_rotation_y) * cos(camera_rotation_x)
		#)
		# rotate around x and then y axis
		camera.position = Vector3(
			camera_distance * cos(camera_rotation_x) * sin(camera_rotation_y),
			-camera_distance * sin(camera_rotation_x),
			camera_distance * cos(camera_rotation_x) * cos(camera_rotation_y)
		)
		camera.look_at(position)
		
		
		#var camera_z = cos(camera_rotation_z)
		#var camera_y = sin(camera_rotation_y)
		#camera.global_position = Vector3(0, camera_y, camera_z)
		#print(camera.global_position)
		
		
		## Calculate the direction from the center to the camera
		#var cam_direction = camera.global_transform.origin - position
		## Rotate this direction vector around the Y-axis (up axis)
		#cam_direction = cam_direction.rotated(Vector3.UP,  CAM_ROTATE_SPEED * -event.relative.x)
		#cam_direction = cam_direction.rotated(Vector3.LEFT, CAM_ROTATE_SPEED * event.relative.y)
		## Set the new camera position
		#camera.global_transform.origin = position + cam_direction
		## Make the camera look at the center point
		#camera.look_at(position, Vector3.UP)


func _physics_process(delta):
	
	
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
		
