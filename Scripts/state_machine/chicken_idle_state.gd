extends NodeState

## Reference to the chicken character body
@export var chicken: Chicken
## Reference to the animated sprite
@export var animated_sprite_2d: AnimatedSprite2D

## Time to stay idle before transitioning
var idle_duration: float = 2.0
var elapsed_time: float = 0.0


func _on_process(_delta: float) -> void:
	pass


func _on_physics_process(delta: float) -> void:
	elapsed_time += delta
	
	# Play idle animation
	animated_sprite_2d.play("idle")


func _on_next_transitions() -> void:
	# Check if player is nearby - trigger squawk
	if chicken.is_player_nearby(80.0):
		transition.emit("squawk")
		return
	
	# After idle duration, transition to another behavior
	if elapsed_time >= idle_duration:
		# Randomly choose next behavior
		var rand = randf()
		if rand < 0.4:
			transition.emit("wander")
		elif rand < 0.6:
			transition.emit("peck")
		elif rand < 0.75:
			transition.emit("bob")
		elif rand < 0.9:
			transition.emit("flap")
		else:
			transition.emit("layegg")


func _on_enter() -> void:
	elapsed_time = 0.0
	idle_duration = randf_range(1.5, 3.0)


func _on_exit() -> void:
	animated_sprite_2d.stop()
