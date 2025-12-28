extends CharacterBody2D

@export var speed := 80.0
@export var patrol_distance := 200.0
@export var max_hp := 50
@export var damage := 999
@export var attack_cooldown := 2.0
@export var apply_gravity := false
@export var patrol_enabled := false

var hp := 0
var is_dead := false
var patrol_start_pos := Vector2.ZERO
var direction := 1
var last_attack_time := 0.0

@onready var sprite: AnimatedSprite2D = get_node_or_null("AnimatedSprite2D")
@onready var attack_area: Area2D = $AttackArea

func _ready():
	hp = max_hp
	patrol_start_pos = global_position
	add_to_group("enemies")
	attack_area.body_entered.connect(_on_attack_area_body_entered)
	attack_area.set_collision_mask_value(1, true)

	# Putar animasi default agar selalu hidup walau tidak patroli
	if sprite:
		sprite.play("default")

func _physics_process(delta):
	if is_dead:
		return
	
	# Gravity (optional). Set apply_gravity = true if ingin mengikuti lantai.
	if apply_gravity and not is_on_floor():
		velocity.y += 980.0 * delta
	else:
		velocity.y = 0
	
	# Patrol movement (optional)
	if patrol_enabled:
		velocity.x = direction * speed
		# Check patrol bounds
		var distance_from_start = global_position.x - patrol_start_pos.x
		if abs(distance_from_start) > patrol_distance:
			direction *= -1
			sprite.flip_h = direction < 0
	else:
		velocity.x = 0
	
	move_and_slide()

func take_damage(amount: int):
	if is_dead:
		return
	
	hp -= amount
	# Flash effect; skip if sprite missing
	if sprite:
		modulate = Color.RED
		await get_tree().create_timer(0.1).timeout
		modulate = Color.WHITE
	
	if hp <= 0:
		die()

func die():
	is_dead = true
	velocity = Vector2.ZERO
	# Death animation - fade out
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 0.0, 0.5)
	await tween.finished
	queue_free()

func _on_attack_area_body_entered(body):
	if body.name == "Player" and not is_dead:
		var current_time = Time.get_ticks_msec() / 1000.0
		if current_time - last_attack_time >= attack_cooldown:
			if body.has_method("take_damage"):
				body.take_damage(damage)
				last_attack_time = current_time
