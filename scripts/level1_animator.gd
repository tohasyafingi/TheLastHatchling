extends Node2D

func _ready() -> void:
	# Animate the middle layer sprites for parallax scrolling effect
	animate_middle_layer()

func animate_middle_layer() -> void:
	# Get the ParallaxLayer2 which contains the middle sprites
	var root = get_parent()  # Get LevelRoot
	var parallax_bg = root.find_child("ParallaxBackground")
	
	if not parallax_bg:
		push_error("ParallaxBackground not found!")
		return
	
	var parallax_layer2 = parallax_bg.find_child("ParallaxLayer2")
	if not parallax_layer2:
		push_error("ParallexLayer2 not found!")
		return
	
	# Get all children of ParallaxLayer2 (the middle sprites)
	var middle_sprites = parallax_layer2.get_children()
	
	# Animate each middle sprite for infinite scrolling
	for sprite in middle_sprites:
		if sprite is Sprite2D:
			# Create an infinite back-and-forth animation
			var tween = create_tween()
			tween.set_loops()
			tween.set_trans(Tween.TRANS_SINE)
			tween.set_ease(Tween.EASE_IN_OUT)
			
			var original_x = sprite.position.x
			var movement_distance = 30.0  # How far to move left-right
			
			# Move right
			tween.tween_property(sprite, "position:x", original_x + movement_distance, 4.0)
			# Move left
			tween.tween_property(sprite, "position:x", original_x - movement_distance, 4.0)
			# Return to center
			tween.tween_property(sprite, "position:x", original_x, 4.0)
