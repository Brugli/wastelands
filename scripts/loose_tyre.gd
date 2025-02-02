extends RigidBody3D

var force = 100

func tyre_hit(source):
	apply_central_force((global_transform.origin - source).normalized() * force)
