extends NodeState

## Reference to the chicken character body
@export var chicken: Chicken
## Reference to the animated sprite
@export var animated_sprite_2d: AnimatedSprite2D
## Reference to the audio player for squawk sound
@export var audio_player: AudioStreamPlayer2D

## Time for squawk animation
var squawk_duration: float = 1.0
var elapsed_time: float = 0.0
var sound_played: bool = false


func _on_process(_delta: float) -> void:
	pass


func _on_physics_process(delta: float) -> void:
	elapsed_time += delta
	
	# Play squawk animation
	animated_sprite_2d.play("squawk")
	
	# Play sound at start of animation
	if not sound_played and audio_player:
		audio_player.play()
		sound_played = true


func _on_next_transitions() -> void:
	# After squawking, return to idle
	if elapsed_time >= squawk_duration:
		transition.emit("idle")


func _on_enter() -> void:
	elapsed_time = 0.0
	sound_played = false


func _on_exit() -> void:
	animated_sprite_2d.stop()
