extends Node

@export var splash_scene: PackedScene
@export var home_scene: PackedScene
@export var level_scene: PackedScene

var current_screen: Node = null

func _ready():
	show_splash()

func swap_to_instance(node: Node):
	if current_screen and is_instance_valid(current_screen):
		current_screen.queue_free()
	current_screen = node
	add_child(node)

func show_splash():
	if splash_scene:
		var s = splash_scene.instantiate()
		if s.has_signal("finished"):
			s.finished.connect(show_home)
		swap_to_instance(s)
	else:
		show_home()

func show_home():
	if home_scene:
		var h = home_scene.instantiate()
		if h.has_signal("start_game"):
			h.start_game.connect(show_level)
		if h.has_signal("quit_game"):
			h.quit_game.connect(get_tree().quit)
		swap_to_instance(h)
	else:
		show_level()

func show_level():
	if level_scene:
		swap_to_instance(level_scene.instantiate())
