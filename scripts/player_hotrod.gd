extends VehicleBody3D

var max_rpm = 800
var max_torque = 300
@onready var locomotive: MeshInstance3D = $Locomotive
@onready var hotrod: MeshInstance3D = $Hotrod

func _physics_process(delta: float) -> void:
	if Global.player_vehicle == "player_hotrod":
		steering = lerp(steering, Input.get_axis("steer_right", "steer_left") * 0.4, 5 * delta)
		var acceleration = Input.get_axis("reverse", "forward")
		var rpm = abs($BackLeft.get_rpm())
		$BackLeft.engine_force = acceleration * max_torque * (1-rpm/max_rpm)
		rpm = abs($BackRight.get_rpm())
		$BackRight.engine_force = acceleration * max_torque * (1-rpm/max_rpm)
	
	#if Input.is_action_just_pressed("customisation"):
		#
		#if !locomotive.is_visible_in_tree():
			#locomotive.visible = true
			#hotrod.visible = false
		#else: 
			#locomotive.visible = false
			#hotrod.visible = true
