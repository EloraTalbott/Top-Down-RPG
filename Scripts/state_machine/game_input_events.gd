class_name GameInputEvents

static var direction: Vector2

static func movement_input() -> Vector2:
	# Start with a zero vector
	direction = Vector2.ZERO
	
	# Add X-axis movement
	if Input.is_action_pressed("walk_left"):
		direction.x = -1
	elif Input.is_action_pressed("walk_right"):
		direction.x = 1
	
	# Add Y-axis movement
	if Input.is_action_pressed("walk_up"):
		direction.y = -1
	elif Input.is_action_pressed("walk_down"):
		direction.y = 1
	
	# Return the combined direction vector
	return direction

static func is_movement_input() -> bool:
	if direction == Vector2.ZERO:
		return false
	return true

static func use_tool() -> bool:
	var use_tool_value: bool = Input.is_action_just_pressed("hit")
	
	return use_tool_value
