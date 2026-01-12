extends Area2D

var is_showing_callout = false  # Track if callout is currently being shown

func _on_body_entered(body: Node2D) -> void:
	if body is player and not is_showing_callout:
		is_showing_callout = true  # Block multiple triggers
		print("Player entered callout area")
		
		# Get the callout sprite
		var callout_sprite = $"../../callout-copper/AnimatedSprite2D"
		
		# Make sure it's visible and fully opaque
		callout_sprite.visible = true
		callout_sprite.modulate.a = 1.0
		
		# Play the fade in animation
		callout_sprite.play("copper-callout")
		
		# Wait 2 seconds
		await get_tree().create_timer(2.0).timeout
		
		# Fade out over 0.5 seconds
		var tween = create_tween()
		tween.tween_property(callout_sprite, "modulate:a", 0.0, 0.5)
		await tween.finished
		
		# Hide and reset
		callout_sprite.visible = false
		callout_sprite.modulate.a = 1.0  # Reset alpha for next time
		
		is_showing_callout = false  # Allow it to trigger again
