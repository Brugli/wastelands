extends RigidBody3D

@export var debug: bool = false

@export var suspension_rest_distance: float = 0.5
@export var spring_strength: float = 500
@export var spring_damper: float = 30
@export var front_wheel_radius: float = 0.5
@export var rear_wheel_radius: float = 0.5

@export var engine_power: float

var acceleration_input: float

@export var steering_angle: float = 20
@export var front_tire_grip: float = 1.0
@export var rear_tire_grip: float = 1.0

var steering_input: float

#@onready var node_3d: Node3D = $CollisionShape3D/Node3D
@onready var node_3d: Node3D = $Node3D

var body_tilt = 270

func _process(delta: float) -> void:
	if Input.is_action_pressed("brake"):
		front_tire_grip = 0.35
		rear_tire_grip = 0.2
	elif Input.is_action_pressed("steer_right") || Input.is_action_pressed("steer_left"):
		front_tire_grip = 0.6
		rear_tire_grip = 0.5
	else:
		front_tire_grip = 0.5
		rear_tire_grip = 0.5
	acceleration_input = Input.get_axis("reverse", "forward")
	steering_input = Input.get_axis("steer_right", "steer_left")
	var steering_rotation = steering_input * steering_angle
	
	var fl_wheel = $wheels/fl_ray
	var fr_wheel = $wheels/fr_ray
	
	if steering_rotation !=0:
		var angle = clamp(fl_wheel.rotation.y + steering_rotation, -steering_angle, steering_angle)
		var new_rotation = angle * delta
		fl_wheel.rotation.y = lerp(fl_wheel.rotation.y, new_rotation, 0.2)
		fr_wheel.rotation.y = lerp(fr_wheel.rotation.y, new_rotation, 0.2) 
	else:
		fl_wheel.rotation.y = lerp(fl_wheel.rotation.y, 0.0, 0.3)
		fr_wheel.rotation.y = lerp(fr_wheel.rotation.y, 0.0, 0.3)
	
	#var t = -steering_input * linear_velocity.length() / -body_tilt
	var r = -acceleration_input * (linear_velocity.length()) / 180
	#node_3d.rotation.z = lerp(node_3d.rotation.z, t, 5.0 * delta)
	node_3d.rotation.x = lerp(node_3d.rotation.x, r, delta)
