extends NodeState

@export var player: Player
@export var animated_sprite_2d: AnimatedSprite2D
@export var speed: int = 75

func _on_process(_delta : float) -> void:
	pass


func _on_physics_process(_delta : float) -> void:
	var direction: Vector2 = GameInputEvents.movement_input()
	
	# Normalize the direction to handle diagonal movement
	if direction != Vector2.ZERO:
		direction = direction.normalized()
	
	# Handle the animation based on direction
	if direction == Vector2.UP:
		animated_sprite_2d.play("walk_back")
	elif direction == Vector2.RIGHT:
		animated_sprite_2d.play("walk_right")
	elif direction == Vector2.DOWN:
		animated_sprite_2d.play("walk_front")
	elif direction == Vector2.LEFT:
		animated_sprite_2d.play("walk_left")
	elif direction.x > 0 and direction.y > 0:
		# Diagonal - UP RIGHT
		animated_sprite_2d.play("walk_back_right")
	elif direction.x < 0 and direction.y > 0:
		# Diagonal - UP LEFT
		animated_sprite_2d.play("walk_back_left")
	elif direction.x > 0 and direction.y < 0:
		# Diagonal - DOWN RIGHT
		animated_sprite_2d.play("walk_front_right")
	elif direction.x < 0 and direction.y < 0:
		# Diagonal - DOWN LEFT
		animated_sprite_2d.play("walk_front_left")
	
	# Update player direction
	if direction != Vector2.ZERO:
		player.player_direction = direction
	
	# Apply velocity and movement
	player.velocity = direction * speed
	player.move_and_slide()

func _on_next_transitions() -> void:
	if !GameInputEvents.is_movement_input():
		transition.emit("idle")


func _on_enter() -> void:
	pass


func _on_exit() -> void:
	animated_sprite_2d.stop()
