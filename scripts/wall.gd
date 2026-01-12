extends AnimatableBody2D

@export var target_plate: Area2D

@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var visual: Node2D = $Sprite2D


var visual_closed_position: Vector2
var tween: Tween

func _ready():
	visual_closed_position = visual.position

	if target_plate:
		target_plate.state_changed.connect(_on_plate_state_changed)
	else:
		push_error("Wall: target_plate not assigned in Inspector")

func _on_plate_state_changed(active: bool):
	if tween:
		tween.kill()

	tween = create_tween()

	if active:
		# Plate pressed: sprite moves downwards and collision shape disappears.
		collision_shape.set_deferred("disabled", true)

		var open_visual_pos = visual_closed_position + Vector2(0, 48)
		tween.tween_property(
			visual,
			"position",
			open_visual_pos,
			1.2
		).set_trans(Tween.TRANS_SINE)

	else:
		# Plate released: sprite moves back and collision shape reappears.
		collision_shape.set_deferred("disabled", false)

		tween.tween_property(
			visual,
			"position",
			visual_closed_position,
			0.5
		).set_trans(Tween.TRANS_SINE)
