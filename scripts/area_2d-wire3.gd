extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body is player:
		set_deferred("monitoring", false)
		
		var copper_area = get_node("../../copper-2/Area2D")
		
		if copper_area.animation_completed:
			print("wire-3-triggered")
			
			# Play wire animation
			var wire_anim = $"../AnimationPlayer"
			wire_anim.play("wires-3")
			
			# Wait for wire animation to finish
			await wire_anim.animation_finished
			
			# Turn OFF left furnace (bulb1)
			get_node("../../Bulbs/bulb1/AnimatedSprite2D").play("closing")
		else:
			print("Push copper first!")
