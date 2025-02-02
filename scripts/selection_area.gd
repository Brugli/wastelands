extends Area3D

@onready var vehicle = get_parent()
@onready var vehicle_selection_scene = get_tree().get_root().get_node("vehicle_selection")
signal vehicle_selected

func _ready() -> void:
	connect("vehicle_selected", vehicle_selection_scene.vehicle_selected)

func _on_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event.is_action_pressed("mouse_clicked"):
		emit_signal("vehicle_selected", vehicle)
