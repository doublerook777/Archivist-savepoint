extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body is wire:
		print("shorted")
		
		# getting the bar1
		var bar1 = get_node("../BARS/bar1")
		var animated_sprite = bar1.get_node("AnimatedSprite2D")
		# playing the animation
		animated_sprite.play("opening")
		# disabling collision safely
		var collision = bar1.get_node("CollisionShape2D")
		collision.set_deferred("disabled", true)
		
		# getting the bar2
		var bar2 = get_node("../BARS/bar2")
		var animated_sprite2 = bar2.get_node("AnimatedSprite2D")
		# playing the animation
		animated_sprite2.play("opening")
		# disabling collision safely
		var collision2 = bar2.get_node("CollisionShape2D")
		collision2.set_deferred("disabled", true)
		
		# getting the bar3
		var bar3 = get_node("../BARS/bar3")
		var animated_sprite3 = bar3.get_node("AnimatedSprite2D")
		# playing the animation
		animated_sprite3.play("opening")
		# disabling collision safely
		var collision3 = bar3.get_node("CollisionShape2D")
		collision3.set_deferred("disabled", true)
