extends Area2D

@export var score_value := 1
@export var heal_amount := 20

@onready var sprite: AnimatedSprite2D = get_node_or_null("AnimatedSprite2D")
@onready var collect_sound: AudioStreamPlayer = get_node_or_null("CollectSound")

func _ready():
	body_entered.connect(_on_body_entered)
	if sprite:
		# Idle float tween so the collectible terlihat hidup namun aman jika node hilang
		var tween = create_tween().set_loops()
		tween.tween_property(sprite, "position:y", -5, 0.5)
		tween.tween_property(sprite, "position:y", 5, 0.5)

func _on_body_entered(body):
	if body.name == "Player":
		collect(body)

func collect(player):
	# Heal player
	if player.has_method("heal"):
		player.heal(heal_amount)
	
	# Play collect sound
	if collect_sound:
		collect_sound.play()
	
	# Notify game manager
	var game_manager = get_tree().get_first_node_in_group("game_manager")
	if game_manager:
		game_manager.add_score(score_value)
	
	# Collect animation
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(self, "scale", Vector2.ZERO, 0.3)
	tween.tween_property(self, "position:y", position.y - 30, 0.3)
	await tween.finished
	queue_free()
