extends Camera3D


var parent
@onready var camera: Camera3D = $"."
#@onready var player_monster_truck: VehicleBody3D = $"../vehicles/player_monster_truck"
#@onready var player_hotrod: VehicleBody3D = $"../vehicles/player_hotrod"
#@onready var player_tank: VehicleBody3D = $"../vehicles/player_tank"
#@onready var player_half_track: VehicleBody3D = $"../vehicles/player_half_track"
#@onready var marker_3d: Marker3D = $"../Marker3D"
#@onready var basic_chassis: RigidBody3D = $"../basic_chassis"
@onready var node_3d: Node3D = $"../Node3D"


func _process(delta):
	#match Global.player_vehicle: 
		#"player_monster_truck":
			#parent = player_monster_truck
		#"player_hotrod":
			#parent = player_hotrod
		#"player_tank":
			#parent = player_tank
		#"player_half_track":
			#parent = player_half_track
		#_:
			#parent = marker_3d
	#var basic_chassis = node_3d.get_child(1)
	#parent = $"../custom_vehicle_1".get_child(0)
	parent = node_3d.get_child(0)
	position = Vector3(parent.position.x, parent.position.y + 25, parent.position.z + 20)
	$".".position = position
