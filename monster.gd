extends CharacterBody2D

const SPEED = 120.0

@export var player: CharacterBody2D

var can_damage = true

func _physics_process(delta):
	if player == null:
		return

	var direction = (player.global_position - global_position).normalized()

	velocity = direction * SPEED
	move_and_slide()

	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)

		if collision.get_collider().name == "Player":
			damage_player()

func damage_player():
	if !can_damage:
		return

	can_damage = false

	var main = get_tree().current_scene

	main.lives -= 1
	main.update_hearts()

	if main.lives <= 0:
		main.show_game_over()

	await get_tree().create_timer(1.0).timeout
	can_damage = true
