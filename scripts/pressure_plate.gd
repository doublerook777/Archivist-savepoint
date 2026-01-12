extends Area2D

signal state_changed(is_active)
@onready var anim_sprite = $AnimatedSprite2D

var occupants = 0 

func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	anim_sprite.play("unpressed")

func _on_body_entered(_body):
	if _is_valid_activator(_body):
		occupants += 1
		_update_state()

func _on_body_exited(_body):
	if _is_valid_activator(_body):
		occupants -= 1
		occupants = max(occupants, 0)
		_update_state()

func _is_valid_activator(body: Node) -> bool:
	if body is CharacterBody2D:
		return true
	elif body.is_in_group("pushable"):
		return true
	return false

func _update_state():
	if occupants > 0:
		anim_sprite.play("pressed")
		state_changed.emit(true)
	else:
		anim_sprite.play("unpressed")
		state_changed.emit(false)
