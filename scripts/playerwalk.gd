extends CharacterBody2D
class_name player
@export var speed: float = 300.0
var push_force = 40.0

@onready var animated_sprite = $AnimatedSprite2D

# Track last non-zero direction for idle animations
var last_direction: Vector2 = Vector2.DOWN

func _physics_process(_delta: float) -> void:
	var input_vector := Vector2.ZERO
	
	# Get input: Works with both arrow keys and WASD keys.
	if Input.is_action_pressed("ui_right") || Input.is_key_pressed(KEY_D):
		input_vector.x += 1
	if Input.is_action_pressed("ui_left") || Input.is_key_pressed(KEY_A):
		input_vector.x -= 1
	if Input.is_action_pressed("ui_down") || Input.is_key_pressed(KEY_S):
		input_vector.y += 1
	if Input.is_action_pressed("ui_up") || Input.is_key_pressed(KEY_W):
		input_vector.y -= 1

	# Normalize diagonal movement
	if input_vector.length() > 0:
		input_vector = input_vector.normalized()
		velocity = input_vector * speed
		move_and_slide()
		
		for i in get_slide_collision_count():
			var c = get_slide_collision(i)
			if c.get_collider() is RigidBody2D:
				c.get_collider().apply_central_impulse(-c.get_normal()*push_force)
		# Handle walking animations
		update_animation("walk", input_vector)
	else:
		# Handle idle animations
		update_animation("idle", last_direction)

func update_animation(state: String, direction: Vector2) -> void:
	# Determine primary direction (horizontal takes priority for side animations)
	var anim_name: String
	var flip_h := false
	
	if abs(direction.x) > abs(direction.y):
		# Horizontal movement is dominant
		anim_name = state + "_side"
		flip_h = direction.x < 0
	else:
		# Vertical movement is dominant
		anim_name = state + ("_down" if direction.y > 0 else "_up")
		flip_h = false
	
	# Apply animation and flip
	animated_sprite.flip_h = flip_h
	if animated_sprite.animation != anim_name:
		animated_sprite.play(anim_name)
