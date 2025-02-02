extends VehicleBody3D

var max_rpm = 800
var max_torque = 750
#@onready var locomotive: MeshInstance3D = $Locomotive
#@onready var hotrod: MeshInstance3D = $Hotrod
@onready var back_right: VehicleWheel3D = $BackRight
@onready var back_left: VehicleWheel3D = $BackLeft

func _physics_process(delta: float) -> void:
	if Global.player_vehicle == "player_tank":
		back_right.steering = lerp(back_right.steering, Input.get_axis("steer_right", "steer_left") * -0.2, 5 * delta)
		back_left.steering = lerp(back_left.steering, Input.get_axis("steer_right", "steer_left") * -0.2, 5 * delta)
		steering = lerp(steering, Input.get_axis("steer_right", "steer_left") * 0.4, 5 * delta)
		var acceleration = Input.get_axis("reverse", "forward")
		var rpm = abs($MiddleLeft.get_rpm())
		$BackLeft.engine_force = acceleration * max_torque * (1-rpm/max_rpm)
		rpm = abs($MiddleLeft.get_rpm())
		$BackRight.engine_force = acceleration * max_torque * (1-rpm/max_rpm)
	
	#if Input.is_action_just_pressed("customisation"):
		#
		#if !locomotive.is_visible_in_tree():
			#locomotive.visible = true
			#hotrod.visible = false
		#else: 
			#locomotive.visible = false
			#hotrod.visible = true
