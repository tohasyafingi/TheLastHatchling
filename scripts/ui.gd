extends CanvasLayer

@export var home_scene_path := "res://scenes/home.tscn"

@onready var health_bar: ProgressBar = $MarginContainer/VBoxContainer/HealthBar
@onready var collectible_label: Label = $MarginContainer/VBoxContainer/CollectibleCounter/CollectibleLabel
@onready var game_over_panel: Panel = $GameOverPanel
@onready var victory_panel: Panel = $VictoryPanel
@onready var checkpoint_panel: Panel = $CheckpointPanel
@onready var restart_button: Button = $GameOverPanel/VBoxContainer/HBoxButtons/RestartButton
@onready var home_button: Button = $GameOverPanel/VBoxContainer/HBoxButtons/HomeButton
@onready var victory_home_button: Button = $VictoryPanel/VBoxContainer/HomeButton
@onready var checkpoint_next_button: Button = $CheckpointPanel/VBoxContainer/HBoxButtons/NextButton
@onready var checkpoint_restart_button: Button = $CheckpointPanel/VBoxContainer/HBoxButtons/RestartButton
@onready var checkpoint_home_button: Button = $CheckpointPanel/VBoxContainer/HBoxButtons/HomeButton

var pending_next_level_path := ""

var score := 0

func _ready():
	game_over_panel.hide()
	victory_panel.hide()
	checkpoint_panel.hide()
	# Keep UI processing while the game tree is paused
	process_mode = Node.PROCESS_MODE_ALWAYS
	restart_button.pressed.connect(_on_restart_pressed)
	home_button.pressed.connect(_on_home_pressed)
	victory_home_button.pressed.connect(_on_home_pressed)
	checkpoint_next_button.pressed.connect(_on_checkpoint_next_pressed)
	checkpoint_restart_button.pressed.connect(_on_restart_pressed)
	checkpoint_home_button.pressed.connect(_on_home_pressed)
	update_score(0)

func update_health(current_hp: int, max_hp: int):
	health_bar.max_value = max_hp
	health_bar.value = current_hp

func update_score(new_score: int):
	score = new_score
	collectible_label.text = str(score)

func add_score(amount: int):
	update_score(score + amount)

func show_game_over():
	get_tree().paused = true
	game_over_panel.show()

func show_victory():
	get_tree().paused = true
	victory_panel.show()

func show_checkpoint_modal(next_level_path: String):
	get_tree().paused = true
	checkpoint_panel.show()
	pending_next_level_path = next_level_path

func _on_restart_pressed():
	var tree := get_tree()
	tree.paused = false
	var level_path := ""
	if tree.has_meta("current_level_path"):
		level_path = str(tree.get_meta("current_level_path"))
	if level_path != "":
		tree.change_scene_to_file(level_path)
	else:
		tree.reload_current_scene()

func _on_home_pressed():
	get_tree().paused = false
	if home_scene_path != "":
		get_tree().change_scene_to_file(home_scene_path)

func _on_checkpoint_next_pressed():
	var tree := get_tree()
	tree.paused = false
	if pending_next_level_path != "":
		tree.change_scene_to_file(pending_next_level_path)
	else:
		tree.reload_current_scene()
