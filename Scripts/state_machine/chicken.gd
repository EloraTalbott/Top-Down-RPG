class_name Chicken
extends CharacterBody2D

## The current direction the chicken is facing
var chicken_direction: Vector2 = Vector2.DOWN

## Timer for random behavior transitions
var behavior_timer: float = 0.0

## Current target position for wandering
var wander_target: Vector2 = Vector2.ZERO

## Reference to player for proximity detection
var player: Node2D = null


func _ready() -> void:
	# Try to find the player node
	var players = get_tree().get_nodes_in_group("player")
	if players.size() > 0:
		player = players[0]


## Check if player is within detection range
func is_player_nearby(detection_range: float = 80.0) -> bool:
	if player == null:
		return false
	return global_position.distance_to(player.global_position) < detection_range


## Get a random wander target within a radius
func get_random_wander_target(radius: float = 100.0) -> Vector2:
	var angle = randf() * TAU
	var distance = randf() * radius
	return global_position + Vector2(cos(angle), sin(angle)) * distance
