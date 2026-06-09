extends CharacterBody2D

const SPEED = 120.0

@export var player: CharacterBody2D

func _physics_process(delta):
	if player == null:
		return

	var direction = (player.global_position - global_position).normalized()

	velocity = direction * SPEED
	move_and_slide()
