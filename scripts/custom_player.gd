extends RigidBody3D


@onready var body_mesh: Node3D = $"../vehicle_node/body_node"
@onready var car_mesh: Node3D = $"../vehicle_node"
@onready var front_wheels: Node3D = $"../vehicle_node/chassis_node".get_child(0).get_child(0)
@onready var back_wheels: Node3D = $"../vehicle_node/chassis_node".get_child(0).get_child(1)
@onready var ground_ray: RayCast3D = $"../vehicle_node/RayCast3D"

var reversing: bool = false
@export var debug: bool = false
var acceleration = 55
@export var steering_angle: float = 25
var turn_speed = 5
var turn_stop_limit = 1.75
var body_tilt = 45
var body_rock = 35
var acceleration_input = 0
var reverse_input = 0
var steering_input
var wheel_speed: Vector3 = Vector3(750,0,0)

func _physics_process(delta):
	 
	is_reversing()
	car_mesh.position = Vector3(global_position.x, global_position.y-1.5, global_position.z)
	if ground_ray.is_colliding():
		var collision_point = ground_ray.get_collision_point()
		apply_central_force(car_mesh.global_transform.basis.z * acceleration_input)
		apply_central_force(car_mesh.global_transform.basis.z * reverse_input)
		
func is_reversing():
	if Input.is_action_just_pressed("reverse"):
		reversing = true
	elif Input.is_action_just_pressed("forward"):
		reversing = false
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not ground_ray.is_colliding():
		return
	acceleration_input = lerp(linear_velocity.length(), (Input.get_action_strength("forward") * acceleration), 1)
	reverse_input = lerp(linear_velocity.length(), (Input.get_action_strength("reverse") * -acceleration), 0.9)
	steering_input = Input.get_axis("steer_right", "steer_left") * deg_to_rad(steering_angle)
	for wheels in front_wheels.get_children():
		wheels.rotation.y = lerp(wheels.rotation.y, steering_input, 0.3)
	if linear_velocity.length() > 15:
		for wheels in front_wheels.get_children():
			wheels.rotation.y = lerp(wheels.rotation.y, -steering_input, 0.5)
	if reversing == true:
		steering_input = Input.get_axis("steer_right", "steer_left") * deg_to_rad(-steering_angle)
		for wheels in front_wheels.get_children():
			wheels.rotation.y = lerp(wheels.rotation.y, -steering_input, 0.3)
	
	if linear_velocity.length() > turn_stop_limit:
		var new_basis = car_mesh.global_transform.basis.rotated(car_mesh.global_transform.basis.y, steering_input)
		car_mesh.global_transform.basis = car_mesh.global_transform.basis.slerp(new_basis, turn_speed * delta)
		car_mesh.global_transform = car_mesh.global_transform.orthonormalized()
		var t = -steering_input * linear_velocity.length() / -body_tilt
		
		var n = ground_ray.get_collision_normal()
		var xform = align_with_y(car_mesh.global_transform, n)
		car_mesh.global_transform = car_mesh.global_transform.interpolate_with(xform, 10.0 * delta)
		if reversing == false:
			for wheels in front_wheels.get_children():
				wheels.rotation_degrees += wheel_speed * delta
			for wheels in back_wheels.get_children():
				wheels.rotation_degrees += (wheel_speed * delta) * 1.5
		elif reversing == true:
			for wheels in front_wheels.get_children():
				wheels.rotation_degrees -= (wheel_speed * delta) * 0.75
			for wheels in back_wheels.get_children():
				wheels.rotation_degrees -= (wheel_speed * delta) 
	#else:
		#var stopped_wheel_speed: Vector3 = Vector3(0,0,0)
		#for wheels in front_wheels.get_children():
			#wheels.rotation_degrees += stopped_wheel_speed * delta
		#for wheels in back_wheels.get_children():
			#wheels.rotation_degrees += stopped_wheel_speed * delta

	var t = -steering_input * linear_velocity.length() / -body_tilt

	if reversing == true:
		t = -steering_input * linear_velocity.length() / body_tilt

	body_mesh.rotation.z = lerp(body_mesh.rotation.z, t, 5.0 * delta)

	if  linear_velocity.length() > 0:
		if reversing == false:
			body_mesh.rotation.x = lerp_angle(body_mesh.rotation.x, (linear_velocity.length() / 2.5) / -body_rock, 5.0 * delta)
		elif reversing == true:
			body_mesh.rotation.x = lerp_angle(body_mesh.rotation.x, (linear_velocity.length() / 2.5) / body_rock, 5.0 * delta)
	else:
		body_mesh.rotation.x = lerp_angle(body_mesh.rotation.x, 0, 5.0 * delta)

func align_with_y(xform, new_y):
	xform.basis.y = new_y
	xform.basis.x = -xform.basis.z.cross(new_y)
#	xform.basis = xform.basis.orthonormalized()
	return xform.orthonormalized()
