extends Node3D

var vehicle
var current_selected_vehicle_name
var selection_area = preload("res://scenes/selection_area.tscn")

func _ready() -> void:
	for vehicle in $vehicles.get_children():
		var selection_area_ins = selection_area.instantiate()
		vehicle.add_child(selection_area_ins)
	
func vehicle_selected(vehicle_selected):
	vehicle = vehicle_selected
	current_selected_vehicle_name = vehicle_selected.name
	$vehicle_label.text = current_selected_vehicle_name
	if current_selected_vehicle_name:
		Global.set_player_vehicle(current_selected_vehicle_name)
		
#func get_player_vehicle():
	#match Global.player_vehicle:
		#"player_monster_truck":
			#vehicle = $vehicles/player_monster_truck
