extends Area2D

@export var required_collectibles := 10
@export var next_scene_path := "res://scenes/level2.tscn"

var triggered := false

@onready var sprite: AnimatedSprite2D = get_node_or_null("AnimatedSprite2D")
@onready var finish_sound: AudioStreamPlayer = get_node_or_null("FinishSound")

func _ready():
	body_entered.connect(_on_body_entered)
	if sprite:
		sprite.play("default")

func _on_body_entered(body):
	if triggered or body.name != "Player":
		return
	var game_manager = get_tree().get_first_node_in_group("game_manager")
	if game_manager and game_manager.has_method("get_collected_count"):
		if game_manager.get_collected_count() >= required_collectibles:
			triggered = true
			# Play finish sound
			if finish_sound:
				finish_sound.play()
			# Wait for sound to finish before transitioning
			var delay = 1.5  # Default delay if sound not available
			if finish_sound and finish_sound.stream:
				delay = finish_sound.stream.get_length() + 0.2  # Add small buffer
			
			await get_tree().create_timer(delay).timeout
			
			# If next_scene_path empty, treat this as final level
			if next_scene_path == "":
				if game_manager.has_method("check_victory"):
					game_manager.check_victory()
			else:
				if game_manager.has_method("on_checkpoint_reached"):
					game_manager.on_checkpoint_reached(next_scene_path)
