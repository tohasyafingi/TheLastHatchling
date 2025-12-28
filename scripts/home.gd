extends Control

signal start_game
signal quit_game

@onready var play_button: Button = $CenterContainer/CardPanel/VBoxContainer/ButtonContainer/PlayButton
@onready var quit_button: Button = $CenterContainer/CardPanel/VBoxContainer/ButtonContainer/QuitButton

func _ready():
	play_button.pressed.connect(_on_play)
	quit_button.pressed.connect(_on_quit)

func _on_play():
	start_game.emit()

func _on_quit():
	quit_game.emit()
