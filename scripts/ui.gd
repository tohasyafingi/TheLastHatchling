extends CanvasLayer

@onready var health_bar: ProgressBar = $MarginContainer/VBoxContainer/HealthBar
@onready var score_label: Label = $MarginContainer/VBoxContainer/ScoreLabel
@onready var game_over_panel: Panel = $GameOverPanel
@onready var victory_panel: Panel = $VictoryPanel
@onready var restart_button: Button = $GameOverPanel/VBoxContainer/RestartButton
@onready var victory_restart_button: Button = $VictoryPanel/VBoxContainer/RestartButton
@onready var final_score_label: Label = $VictoryPanel/VBoxContainer/FinalScoreLabel

var score := 0

func _ready():
	game_over_panel.hide()
	victory_panel.hide()
	restart_button.pressed.connect(_on_restart_pressed)
	victory_restart_button.pressed.connect(_on_restart_pressed)
	update_score(0)

func update_health(current_hp: int, max_hp: int):
	health_bar.max_value = max_hp
	health_bar.value = current_hp

func update_score(new_score: int):
	score = new_score
	score_label.text = "Score: " + str(score)

func add_score(amount: int):
	update_score(score + amount)

func show_game_over():
	game_over_panel.show()

func show_victory():
	final_score_label.text = "Final Score: " + str(score)
	victory_panel.show()

func _on_restart_pressed():
	get_tree().reload_current_scene()
