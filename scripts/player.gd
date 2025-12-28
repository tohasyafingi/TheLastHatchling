extends CharacterBody2D

@export var speed := 160.0
@export var jump_force := -320.0
@export var gravity := 1000.0
@export var max_hp := 100
@export var can_attack := true

var hp := 0
var is_attacking := false
var is_dead := false
var last_safe_y := 0.0
var fall_start_y := 0.0
var is_falling := false

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var attack_area: Area2D = $AttackArea
@onready var jump_sound: AudioStreamPlayer = $JumpSound
@onready var attack_sound: AudioStreamPlayer = $AttackSound
@onready var die_sound: AudioStreamPlayer = $DieSound
@onready var after_die_sound: AudioStreamPlayer = $AfterDieSound
@onready var step_sound: AudioStreamPlayer = $StepSound

var step_timer := 0.0

signal player_died
signal health_changed(new_hp: int, max_hp: int)

func _ready():
	hp = max_hp
	last_safe_y = global_position.y
	animated_sprite.animation_finished.connect(_on_AnimatedSprite2D_animation_finished)
	health_changed.emit(hp, max_hp)

func _physics_process(delta):
	if is_dead:
		return

	if not is_on_floor():
		velocity.y += gravity * delta
		if not is_falling:
			is_falling = true
			fall_start_y = global_position.y
	else:
		if is_falling:
			var fall_distance = global_position.y - fall_start_y
			if fall_distance > 160:
				die()
			is_falling = false
		last_safe_y = global_position.y

	handle_movement()
	handle_jump()
	move_and_slide()
	update_animation()

func handle_movement():
	if is_attacking:
		velocity.x = 0
		return

	var dir := Input.get_axis("ui_left", "ui_right")
	velocity.x = dir * speed

	if dir != 0:
		animated_sprite.flip_h = dir < 0
		# Play step sound saat bergerak di lantai
		if is_on_floor():
			step_timer -= get_physics_process_delta_time()
			if step_timer <= 0.0:
				if step_sound:
					step_sound.play()
				step_timer = 0.25  # Interval antar langkah (40px spacing @ 160px/s)

func handle_jump():
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_force
		if jump_sound:
			jump_sound.play()

func _input(event):
	if can_attack and event.is_action_pressed("attack") and not is_attacking and not is_dead:
		attack()

func attack():
	is_attacking = true
	velocity.x = 0
	animated_sprite.play("attack")
	if attack_sound:
		attack_sound.play()
	check_attack_hit()
	# Fallback timeout jika animation_finished tidak dipanggil
	get_tree().create_timer(0.6).timeout.connect(func(): 
		if is_attacking and animated_sprite.animation == "attack":
			is_attacking = false
	)

func take_damage(amount: int):
	if is_dead:
		return

	hp -= amount
	health_changed.emit(hp, max_hp)
	if hp <= 0:
		die()

func heal(amount: int):
	if is_dead:
		return
	
	hp = min(hp + amount, max_hp)
	health_changed.emit(hp, max_hp)

func die():
	is_dead = true
	velocity = Vector2.ZERO
	animated_sprite.play("death")
	if die_sound:
		die_sound.play()
	player_died.emit()


func update_animation():
	if is_dead or is_attacking:
		return

	if not is_on_floor():
		animated_sprite.play("jump")
	elif velocity.x != 0:
		animated_sprite.play("run")
	else:
		animated_sprite.play("idle")

func check_attack_hit():
	var enemies = get_tree().get_nodes_in_group("enemies")
	for enemy in enemies:
		if enemy.has_method("take_damage"):
			var distance = global_position.distance_to(enemy.global_position)
			if distance < 100:
				var direction = (enemy.global_position - global_position).normalized()
				if (direction.x > 0 and not animated_sprite.flip_h) or (direction.x < 0 and animated_sprite.flip_h):
					enemy.take_damage(25)

func _on_AnimatedSprite2D_animation_finished():
	if animated_sprite.animation == "attack":
		is_attacking = false
	elif animated_sprite.animation == "death":
		if after_die_sound:
			after_die_sound.play()
		await get_tree().create_timer(1.0).timeout
