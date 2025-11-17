extends StaticBody2D

## Lifetime of the egg before it disappears
@export var lifetime: float = 30.0

var elapsed_time: float = 0.0


func _ready() -> void:
	# Start with full opacity
	modulate.a = 1.0


func _process(delta: float) -> void:
	elapsed_time += delta
	
	# Fade out in the last 5 seconds
	if elapsed_time >= lifetime - 5.0:
		var fade_progress = (elapsed_time - (lifetime - 5.0)) / 5.0
		modulate.a = 1.0 - fade_progress
	
	# Remove when lifetime expires
	if elapsed_time >= lifetime:
		queue_free()
