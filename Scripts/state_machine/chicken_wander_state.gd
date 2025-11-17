extends NodeState

## Reference to the chicken character body
@export var chicken: Chicken
## Reference to the animated sprite
@export var animated_sprite_2d: AnimatedSprite2D
## Movement speed
@export var speed: int = 30

## Time to wander before stopping
var wander_duration: float = 3.0
var elapsed_time: float = 0.0
var direction: Vector2 = Vector2.ZERO


func _on_process(_delta: float) -> void:
	pass


func _on_physics_process(delta: float) -> void:
	elapsed_time += delta
	
	# Play walk animation
	animated_sprite_2d.play("walk")
	
	# Move in the chosen direction
	chicken.velocity = direction * speed
	chicken.move_and_slide()


func _on_next_transitions() -> void:
	# Check if player is nearby - trigger squawk
	if chicken.is_player_nearby(80.0):
		transition.emit("squawk")
		return
	
	# After wander duration, return to idle
	if elapsed_time >= wander_duration:
		transition.emit("idle")


func _on_enter() -> void:
	elapsed_time = 0.0
	wander_duration = randf_range(2.0, 4.0)
	
	# Choose a random direction
	var angle = randf() * TAU
	direction = Vector2(cos(angle), sin(angle)).normalized()
	chicken.chicken_direction = direction


func _on_exit() -> void:
	animated_sprite_2d.stop()
	chicken.velocity = Vector2.ZERO
