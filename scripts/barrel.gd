extends RigidBody3D

@onready var timer: Timer = $Timer
var busted: bool = false
@onready var barrel: MeshInstance3D = $CollisionShape3D/barrel
@onready var exploded_barrel: MeshInstance3D = $CollisionShape3D/exploded_barrel

func _ready() -> void:
	contact_monitor = true
	set_max_contacts_reported(10)



func _on_timer_timeout() -> void:
	var bodies = $Area3D.get_overlapping_bodies()
	for obj in bodies:
		if obj.is_in_group("terrain_tyres"):
			var source = self.global_transform.origin
			obj.tyre_hit(source)
	busted = true
	barrel.queue_free()
	exploded_barrel.visible = true
	
func _on_body_entered(body: Node) -> void:
	if busted == true:
		return
	if body.name == "custom_vehicle_1_pb":
		print("exploding")
		timer.start()
