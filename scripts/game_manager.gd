extends Node2D

@onready var ui: CanvasLayer = $UI
@onready var player: CharacterBody2D = $Player
@onready var music: AudioStreamPlayer = get_node_or_null("BackgroundMusic")
@onready var open_sound: AudioStreamPlayer = get_node_or_null("OpenSound")

var total_collectibles := 0
var collected := 0
var death_zone_y := 1000

func _ready():
	add_to_group("game_manager")
	# Track the current level path so UI can restart the active level even when wrapped by a main scene
	if scene_file_path != "":
		get_tree().set_meta("current_level_path", scene_file_path)
	
	# Putar sound open saat game dimulai
	if open_sound:
		open_sound.play()
	
	# Putar musik background Backsound (loop otomatis)
	if music:
		music.bus = &"Master"
		music.volume_db = -8.0
		music.play()
	
	total_collectibles = get_tree().get_nodes_in_group("collectibles").size()
	
	if player:
		player.health_changed.connect(_on_player_health_changed)
		player.player_died.connect(_on_player_died)

func _process(_delta):
	if player and player.global_position.y > death_zone_y:
		if not player.is_dead:
			player.die()

func add_score(amount: int):
	if ui:
		ui.add_score(amount)
	collected += 1
	# Don't auto-trigger victory; checkpoint will handle level progression

func get_collected_count() -> int:
	return collected

func load_scene(path: String):
	# Deferred load to avoid conflicts when called during body_entered
	await get_tree().create_timer(0.1).timeout
	get_tree().change_scene_to_file(path)

func on_checkpoint_reached(next_scene_path: String):
	if ui and ui.has_method("show_checkpoint_modal"):
		ui.show_checkpoint_modal(next_scene_path)

func check_victory():
	await get_tree().create_timer(0.5).timeout
	if ui:
		ui.show_victory()

func _on_player_health_changed(current_hp: int, max_hp: int):
	if ui:
		ui.update_health(current_hp, max_hp)

func _on_player_died():
	await get_tree().create_timer(1.5).timeout
	if ui:
		ui.show_game_over()
