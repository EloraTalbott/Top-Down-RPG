extends NodeState

## Reference to the chicken character body
@export var chicken: Chicken
## Reference to the animated sprite
@export var animated_sprite_2d: AnimatedSprite2D

## Time to bob head
var bob_duration: float = 1.0
var elapsed_time: float = 0.0


func _on_process(_delta: float) -> void:
	pass


func _on_physics_process(delta: float) -> void:
	elapsed_time += delta
	
	# Play bob animation
	animated_sprite_2d.play("bob")


func _on_next_transitions() -> void:
	# Check if player is nearby - trigger squawk
	if chicken.is_player_nearby(80.0):
		transition.emit("squawk")
		return
	
	# After bobbing, return to idle
	if elapsed_time >= bob_duration:
		transition.emit("idle")


func _on_enter() -> void:
	elapsed_time = 0.0
	bob_duration = randf_range(0.8, 1.5)


func _on_exit() -> void:
	animated_sprite_2d.stop()
