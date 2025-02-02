extends Node3D

var time = 0
var speed_div = 100
var offset = 0.5
var speed

@onready var links = $Path3D.get_children()
@onready var drive: VehicleWheel3D = $"../BackLeft"

func _process(delta):
	if Input.get_axis("forward", "reverse"):
		speed = (1+drive.get_rpm()/100)
	else:
		speed = 0
	time += delta
	var count = 0
	for index in links:
		index.progress = speed * time + (offset * count)
		count+=1
