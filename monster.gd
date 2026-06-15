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

func _on_area_2d_body_entered(body):
	if body.name != "Player":
		return

	if !can_damage:
		return

	can_damage = false

	var main = get_tree().current_scene

	main.lives -= 1
	main.update_hearts()

	if main.lives <= 0:
		get_tree().change_scene_to_file("res://GameOver.tscn")

	await get_tree().create_timer(1.0).timeout
	can_damage = true
