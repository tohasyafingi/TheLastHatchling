extends CanvasLayer

@onready var left_button = $VBoxContainer/HBoxContainer/LeftButton
@onready var right_button = $VBoxContainer/HBoxContainer/RightButton
@onready var jump_button = $VBoxContainer/HBoxContainer/RightControls/JumpButton
@onready var attack_button = $VBoxContainer/HBoxContainer/RightControls/AttackButton

var player: CharacterBody2D

func _ready() -> void:
	# Find the player in the scene - try both "Player" and "PlayerBody"
	player = get_tree().root.find_child("Player", true, false)
	
	if not player:
		player = get_tree().root.find_child("PlayerBody", true, false)
	
	if not player:
		push_error("Player not found!")
		return
	
	# Connect button signals
	left_button.button_down.connect(_on_left_pressed)
	left_button.button_up.connect(_on_left_released)
	right_button.button_down.connect(_on_right_pressed)
	right_button.button_up.connect(_on_right_released)
	jump_button.pressed.connect(_on_jump_pressed)
	attack_button.pressed.connect(_on_attack_pressed)

func _on_left_pressed() -> void:
	if player and player.has_method("set_move_direction"):
		player.set_move_direction(-1)

func _on_left_released() -> void:
	if player and player.has_method("set_move_direction"):
		player.set_move_direction(0)

func _on_right_pressed() -> void:
	if player and player.has_method("set_move_direction"):
		player.set_move_direction(1)

func _on_right_released() -> void:
	if player and player.has_method("set_move_direction"):
		player.set_move_direction(0)

func _on_jump_pressed() -> void:
	if player and player.has_method("jump"):
		player.jump()

func _on_attack_pressed() -> void:
	if player and player.has_method("request_attack"):
		player.request_attack()
