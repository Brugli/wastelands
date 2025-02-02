extends Node3D

@onready var rigid_body_3d: RigidBody3D = $RigidBody3D
@onready var body_node: Node3D = $vehicle_node/body_node
@onready var chassis_node: Node3D = $vehicle_node/chassis_node

@onready var interceptor = preload("res://scenes/vehicle_parts/interceptor_body.tscn")
@onready var hotrod = preload("res://scenes/vehicle_parts/hotrod_body.tscn")
@onready var impala = preload("res://scenes/vehicle_parts/impala_body.tscn")
@onready var basic_chassis = preload("res://scenes/vehicle_parts/basic_chassis.tscn")
@onready var truck_chassis = preload("res://scenes/vehicle_parts/truck_chassis.tscn")
var body: Array = []
var body_index = 0
var chassis: Array = []
var chassis_index = 0

func _ready() -> void:
	var int_ins = interceptor.instantiate()
	var hot_ins = hotrod.instantiate()
	var imp_ins = impala.instantiate()
	var bas_ins = basic_chassis.instantiate()
	var tru_ins = truck_chassis.instantiate()
	body.append(int_ins)
	body.append(hot_ins)
	body.append(imp_ins)
	chassis.append(bas_ins)
	chassis.append(tru_ins)
	
func _process(delta: float) -> void:
	if chassis_index == 1:
		body_node.position = Vector3(0,0.6,0)
	else:
		body_node.position = Vector3(0,0,0)
	if Input.is_action_just_pressed("cycle_body"):
		body_index += 1
		if body_index > body.size() - 1:
			body_index = 0
		body_node.add_child(body[body_index])
		body_node.remove_child(body_node.get_child(0))
		
	if Input.is_action_just_pressed("cycle_chassis"):
		chassis_index += 1
		if chassis_index > chassis.size() - 1:
			chassis_index = 0
		chassis_node.add_child(chassis[chassis_index])
		chassis_node.remove_child(chassis_node.get_child(0))
