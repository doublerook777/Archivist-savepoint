extends Area2D

var is_first_push = true  # Track if it's the first or second push
var is_animating = false  # Track if animation is currently playing

func _on_body_entered(body: Node2D) -> void:
	if body is player and not is_animating:  # Only detect if not animating
		is_animating = true  # Block further detections
		
		if is_first_push:
			print("First push")
			
			# Disable callout detection areas
			$"../callouts".monitoring = false  # Copper's callout detector
			$"../../wood/callout-wood".monitoring = false  # Wood's callout detector
			
			# Playing copper animation
			var copper_anim = $"../AnimationPlayer"
			copper_anim.play("copper")
			# Playing wood animation
			$"../../wood/AnimationPlayer".play("wood")
			
			# Play the first callout animation
			$"../../callout-copper/AnimationPlayer".play("callout_move_1")  # Replace with your animation name
			
			# Wait for animation to finish
			await copper_anim.animation_finished
			
			is_first_push = false  # Switch to second state
			is_animating = false  # Re-enable detection
		else:
			print("Second push")
			# Play the second animations
			var copper_anim = $"../AnimationPlayer"
			copper_anim.play("copper-2")
			$"../../wood/AnimationPlayer".play("wood-2")
			
			# Play the second callout animation
			$"../../callout-copper/AnimationPlayer".play("callout_move_2")  # Replace with your animation name
			
			# Wait for animation to finish
			await copper_anim.animation_finished
			
			# Open the door
			var door = get_node("../../DOOR")
			var door_anim = door.get_node("AnimatedSprite2D")
			door_anim.play("opening")
			
			# Disable door collision
			var door_collision = door.get_node("CollisionShape2D")
			door_collision.set_deferred("disabled", true)
			
			# Permanently disable this Area2D's detection
			monitoring = false
