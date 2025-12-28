extends Control

signal finished
@export var auto_time := 2.0

@onready var timer: Timer = $Timer

func _ready():
	timer.wait_time = auto_time
	timer.start()

func _on_Timer_timeout():
	finished.emit()

func _unhandled_input(event):
	if event.is_action_pressed("ui_accept"):
		finished.emit()
	elif event is InputEventMouseButton and event.pressed:
		finished.emit()
