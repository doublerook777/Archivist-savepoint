extends RigidBody2D

func _ready():
	add_to_group("pushable") # This identifies it for the plate and player
