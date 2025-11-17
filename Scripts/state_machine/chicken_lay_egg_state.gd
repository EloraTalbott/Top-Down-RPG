extends NodeState

## Reference to the chicken character body
@export var chicken: Chicken
## Reference to the animated sprite
@export var animated_sprite_2d: AnimatedSprite2D
## Egg scene to spawn
@export var egg_scene: PackedScene

## Time for laying egg animation
var lay_duration: float = 2.0
var elapsed_time: float = 0.0
var egg_spawned: bool = false


func _on_process(_delta: float) -> void:
	pass


func _on_physics_process(delta: float) -> void:
	elapsed_time += delta
	
	# Play lay egg animation
	animated_sprite_2d.play("layegg")
	
	# Spawn egg at 75% through animation
	if elapsed_time >= lay_duration * 0.75 and not egg_spawned and egg_scene:
		spawn_egg()
		egg_spawned = true


func _on_next_transitions() -> void:
	# After laying egg, return to idle
	if elapsed_time >= lay_duration:
		transition.emit("idle")


func _on_enter() -> void:
	elapsed_time = 0.0
	egg_spawned = false


func _on_exit() -> void:
	animated_sprite_2d.stop()


## Spawn an egg at the chicken's position
func spawn_egg() -> void:
	if egg_scene:
		var egg = egg_scene.instantiate()
		egg.global_position = chicken.global_position + Vector2(0, 10)
		chicken.get_parent().add_child(egg)
