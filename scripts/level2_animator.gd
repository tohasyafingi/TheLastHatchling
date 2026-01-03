extends Node2D

func _ready() -> void:
	# Animate the background sprites for parallax scrolling effect
	animate_background()

func animate_background() -> void:
	# Get the ParallaxLayer which contains the background sprites
	var root = get_parent()  # Get Level2Root or similar
	var parallax_bg = root.find_child("ParallaxBackground")
	
	if not parallax_bg:
		push_error("ParallaxBackground not found!")
		return
	
	var parallax_layer = parallax_bg.find_child("ParallaxLayer")
	if not parallax_layer:
		push_error("ParallexLayer not found!")
		return
	
	# Get all children of ParallexLayer (the background sprites)
	var bg_sprites = parallax_layer.get_children()
	
	# Animate each background sprite for infinite scrolling
	for i in range(bg_sprites.size()):
		var sprite = bg_sprites[i]
		if sprite is Sprite2D:
			# Create an infinite back-and-forth animation
			var tween = create_tween()
			tween.set_loops()
			tween.set_trans(Tween.TRANS_SINE)
			tween.set_ease(Tween.EASE_IN_OUT)
			
			var original_x = sprite.position.x
			var movement_distance = 25.0  # How far to move left-right
			
			# Move right
			tween.tween_property(sprite, "position:x", original_x + movement_distance, 5.0)
			# Move left
			tween.tween_property(sprite, "position:x", original_x - movement_distance, 5.0)
			# Return to center
			tween.tween_property(sprite, "position:x", original_x, 5.0)
