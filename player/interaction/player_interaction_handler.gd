extends Area3D

@export var item_types: Array[item_data] = []

var nearby_bodies: Array[interactable_item]

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		PickupNearestItem()
		
func PickupNearestItem():
	var nearest_item: interactable_item = null
	var nearest_item_distance: float = INF
	for item in nearby_bodies:
		if item.global_position.distance_to(global_position) < nearest_item_distance:
			nearest_item_distance = item.global_position.distance_to(global_position)
			nearest_item = item
			
	if nearest_item != null:
		nearest_item.queue_free()
		nearby_bodies.remove_at(nearby_bodies.find(nearest_item))
		var item_prefab = nearest_item.scene_file_path
		for i in item_types.size():
			if item_types[i].world_model != null and item_types[i].world_model.resource_path == item_prefab:
				print("Item Id:" + str(i) + " Name:" + item_types[i].name)
				return
				
		printerr("Item Not Found")

func OnEntered(body: Node3D):
	if body is interactable_item:
		body.GainFocus()
		nearby_bodies.append(body)

func OnExited(body: Node3D):
	if body is interactable_item and nearby_bodies.has(body):
		body.LoseFocus()
		nearby_bodies.remove_at(nearby_bodies.find(body))
