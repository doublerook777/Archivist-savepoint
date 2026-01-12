extends Area2D

var is_animating = false
var animation_completed = false

func _on_body_entered(body: Node2D) -> void:
	if body is player and not is_animating:
		is_animating = true
		print("copper-2-pushed")
		
		$"../AnimationPlayer".play("copper-2")
		await $"../AnimationPlayer".animation_finished
		
		$"../CollisionShape2D".set_deferred("disabled", true)
		
		var bulb1_sprite = get_node("../../Bulbs/bulb1/AnimatedSprite2D")
		var bulb2_sprite = get_node("../../Bulbs/bulb2/AnimatedSprite2D")
		var bulb3_sprite = get_node("../../Bulbs/bulb3/AnimatedSprite2D")
		
		bulb1_sprite.play("opening")
		bulb2_sprite.play("opening")
		bulb3_sprite.play("opening")
		
		# Wait for opening animation to finish, then play idle
		await bulb1_sprite.animation_finished
		bulb1_sprite.play("idle")
		bulb2_sprite.play("idle")
		bulb3_sprite.play("idle")
		
		animation_completed = true
		monitoring = false
