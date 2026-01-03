extends CanvasLayer

@onready var left_button = $VBoxContainer/HBoxContainer/LeftButton
@onready var right_button = $VBoxContainer/HBoxContainer/RightButton
@onready var jump_button = $VBoxContainer/HBoxContainer/RightControls/JumpButton
@onready var attack_button = $VBoxContainer/HBoxContainer/RightControls/AttackButton

var player: CharacterBody2D
var left_touches: Dictionary = {} # touch index -> true for left hold
var right_touches: Dictionary = {} # touch index -> true for right hold

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
	set_process_input(true)

func _input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		_handle_touch(event)
	elif event is InputEventScreenDrag:
		_handle_drag(event)

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

func _handle_touch(event: InputEventScreenTouch) -> void:
	var pos := event.position
	if event.pressed:
		if _is_inside(left_button, pos):
			left_touches[event.index] = true
		if _is_inside(right_button, pos):
			right_touches[event.index] = true
		if _is_inside(jump_button, pos):
			_on_jump_pressed()
		if _is_inside(attack_button, pos):
			_on_attack_pressed()
	else:
		left_touches.erase(event.index)
		right_touches.erase(event.index)
	_update_direction()

func _handle_drag(event: InputEventScreenDrag) -> void:
	var pos := event.position
	# Update existing touch assignment based on movement between buttons.
	var moved_left := left_touches.has(event.index)
	var moved_right := right_touches.has(event.index)

	if moved_left and not _is_inside(left_button, pos):
		left_touches.erase(event.index)
	if moved_right and not _is_inside(right_button, pos):
		right_touches.erase(event.index)

	# Reassign if the finger moves into the other button.
	if _is_inside(left_button, pos):
		left_touches[event.index] = true
		right_touches.erase(event.index)
	elif _is_inside(right_button, pos):
		right_touches[event.index] = true
		left_touches.erase(event.index)

	_update_direction()

func _update_direction() -> void:
	var dir := 0
	if left_touches.size() > 0:
		dir -= 1
	if right_touches.size() > 0:
		dir += 1
	if player and player.has_method("set_move_direction"):
		player.set_move_direction(dir)

func _is_inside(control: Control, point: Vector2) -> bool:
	return control.get_global_rect().has_point(point)

func _on_jump_pressed() -> void:
	if player and player.has_method("jump"):
		player.jump()

func _on_attack_pressed() -> void:
	if player and player.has_method("request_attack"):
		player.request_attack()
