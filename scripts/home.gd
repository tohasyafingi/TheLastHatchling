extends Control

signal start_game
signal quit_game

@export var level_scene_path := "res://scenes/level1.tscn"

@onready var play_button: TextureButton = $VBoxContainer/BottomSection/Content/PlayButton
@onready var player_body: CharacterBody2D = $VBoxContainer/TopSection/PlayerDisplay/PlayerBody
@onready var player_sprite: AnimatedSprite2D = $VBoxContainer/TopSection/PlayerDisplay/PlayerBody/PlayerSprite
@onready var animation_timer: Timer = $AnimationTimer
@onready var player_display: CenterContainer = $VBoxContainer/TopSection/PlayerDisplay
@onready var jump_sound: AudioStreamPlayer = $VBoxContainer/TopSection/PlayerDisplay/PlayerBody/JumpSound
@onready var attack_sound: AudioStreamPlayer = $VBoxContainer/TopSection/PlayerDisplay/PlayerBody/AttackSound
@onready var step_sound: AudioStreamPlayer = $VBoxContainer/TopSection/PlayerDisplay/PlayerBody/StepSound

var animations = ["idle", "run", "jump", "attack"]
var current_anim_index = 0
var move_speed = 200.0
var move_direction = 1.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var jump_force = 550.0
var velocity := Vector2.ZERO
var action_time = 0.0
var current_action = "idle"
var target_position = Vector2.ZERO
var start_position = Vector2.ZERO
var jump_time = 0.0
var display_rect = Rect2()
var step_timer := 0.0

func _ready():
	play_button.pressed.connect(_on_play)
	animation_timer.timeout.connect(_on_animation_timer_timeout)
	player_sprite.play("idle")
	
	# Tunggu sampai layout siap
	await get_tree().process_frame
	await get_tree().process_frame
	
	start_position = player_body.position
	display_rect = player_display.get_rect()
	
	_start_random_action()

func _physics_process(delta):
	action_time += delta
	
	# Batasi posisi player hanya jika display_rect sudah valid
	if display_rect.size.x > 0:
		var margin_x = 200.0
		player_body.position.x = clamp(player_body.position.x, margin_x, display_rect.size.x - margin_x)

	# Terapkan gravitasi
	velocity.y += gravity * delta

	match current_action:
		"run":
			var dir = sign(target_position.x - player_body.position.x)
			if dir == 0:
				dir = move_direction
			move_direction = dir
			velocity.x = move_speed * dir
			
			# Play step sound when moving on floor
			if player_body.is_on_floor():
				step_timer -= delta
				if step_timer <= 0.0:
					if step_sound:
						step_sound.play()
					step_timer = 0.25
			
			if abs(player_body.position.x - target_position.x) < 10.0:
				_start_random_action()
		
		"jump":
			if player_body.is_on_floor() and jump_time == 0.0:
				velocity.y = -jump_force
				if jump_sound:
					jump_sound.play()
			jump_time += delta
			var dir_j = sign(target_position.x - player_body.position.x)
			if dir_j == 0:
				dir_j = move_direction
			move_direction = dir_j
			velocity.x = move_speed * 0.8 * dir_j
			if jump_time > 1.2:
				_start_random_action()
		
		"idle", "attack":
			velocity.x = lerp(velocity.x, 0.0, delta * 5.0)

	# Gerakkan karakter dengan slide
	player_body.velocity = velocity
	player_body.move_and_slide()
	velocity = player_body.velocity

	# Update flip
	if abs(velocity.x) > 5.0:
		player_sprite.flip_h = velocity.x < 0

	# Ganti aksi secara random setiap beberapa detik
	if action_time > randf_range(2.5, 4.0):
		_start_random_action()

func _start_random_action():
	action_time = 0.0
	jump_time = 0.0
	start_position = player_body.position
	
	var rand_action = randi() % 4
	
	# Gunakan ukuran PlayerDisplay dengan margin yang lebih besar
	var margin = 200.0
	var min_x = margin
	var max_x = max(display_rect.size.x - margin, margin + 100)
	var center_x = display_rect.size.x / 2
	
	match rand_action:
		0:
			current_action = "idle"
			player_sprite.play("idle")
		1:
			current_action = "run"
			player_sprite.play("run")
			# Set target position untuk run dalam area PlayerDisplay
			if player_body.position.x < center_x:
				target_position.x = randf_range(center_x + 50, max_x)
				move_direction = 1.0
				player_sprite.flip_h = false
			else:
				target_position.x = randf_range(min_x, center_x - 50)
				move_direction = -1.0
				player_sprite.flip_h = true
		2:
			current_action = "jump"
			player_sprite.play("jump")
			# Set target position untuk jump dalam area PlayerDisplay
			target_position.x = randf_range(min_x, max_x)
			player_sprite.flip_h = (target_position.x < player_body.position.x)
		3:
			current_action = "attack"
			player_sprite.play("attack")
			if attack_sound:
				attack_sound.play()

func _on_animation_timer_timeout():
	# Timer tidak lagi digunakan untuk ganti animasi
	pass

func _on_play():
	start_game.emit()
	# Fallback: if no parent listener (main.gd not present), load level directly
	if get_parent() == get_tree().root:
		get_tree().change_scene_to_file(level_scene_path)

func _on_quit():
	quit_game.emit()
