extends Node3D
class_name interactable_item

@export var item_highlight_mesh: MeshInstance3D

func GainFocus():
	item_highlight_mesh.visible = true
	
func LoseFocus():
	item_highlight_mesh.visible = false
