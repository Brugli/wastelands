extends VehicleBody3D

var max_rpm = 950
var max_torque = 750
@onready var back_right: VehicleWheel3D = $BackRight
@onready var back_left: VehicleWheel3D = $BackLeft

func _physics_process(delta: float) -> void:
	if Global.player_vehicle == "player_half_track":
		back_right.steering = lerp(back_right.steering, Input.get_axis("steer_right", "steer_left") * -0.1, 5 * delta)
		back_left.steering = lerp(back_left.steering, Input.get_axis("steer_right", "steer_left") * -0.1, 5 * delta)
		steering = lerp(steering, Input.get_axis("steer_right", "steer_left") * 0.4, 5 * delta)
		var acceleration = Input.get_axis("reverse", "forward")
		var rpm = abs($MiddleLeft.get_rpm())
		$BackLeft.engine_force = acceleration * max_torque * (1-rpm/max_rpm)
		rpm = abs($MiddleLeft.get_rpm())
		$BackRight.engine_force = acceleration * max_torque * (1-rpm/max_rpm)
