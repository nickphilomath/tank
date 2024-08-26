extends Camera3D

@export var target: Node3D

const CAM_ROTATE_SPEED = 0.003

var rotation_a = 0  # radian
var rotation_b = 0  # radianVehicleWheel3D
var distance = 7 # unit


func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			distance -= 1
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			distance += 1
			
	elif event is InputEventMouseMotion:
		rotation_a += CAM_ROTATE_SPEED * -event.relative.y
		rotation_b += CAM_ROTATE_SPEED * -event.relative.x


func _process(delta):
	# rotate around x and then y axis
	position = Vector3(
		target.position.x + distance * cos(rotation_a) * sin(rotation_b),
		target.position.y - distance * sin(rotation_a),
		target.position.z + distance * cos(rotation_a) * cos(rotation_b)
	)
	look_at(target.position)
