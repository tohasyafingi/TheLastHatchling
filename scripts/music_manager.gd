extends AudioStreamPlayer

# Background music manager - putar musik loop otomatis

func _ready():
	bus = &"Master"
	play()
