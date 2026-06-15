extends Node2D

var lives = 3
var survival_time = 0.0
var game_won = false

var timer_wait_time = 1.0

var questions = [
	{
		"question": "What is 2 + 2?",
		"choices": ["3", "4", "5"],
		"correct": "4"
	},
	{
		"question": "What color is the sky?",
		"choices": ["red", "blue", "green"],
		"correct": "blue"
	}
]

var current_answer = ""

var full_heart = preload("res://sprites/heart.png")
var empty_heart = preload("res://sprites/heart_empty.png")

func _ready():
	$QuestionPanel.visible = false

	$QuestionPanel.process_mode = Node.PROCESS_MODE_ALWAYS
	$QuestionPanel.answer_selected.connect(check_answer)

	$Timer.wait_time = timer_wait_time
	$Timer.start()

	update_hearts()

func _on_timer_timeout():
	var q = questions.pick_random()

	current_answer = q["correct"].to_lower()

	$QuestionPanel.setup(q)
	$QuestionPanel.visible = true

	get_tree().paused = true

func check_answer(answer, button):
	if answer.to_lower() == current_answer:
		print("Correct!")

		get_tree().paused = false
		$QuestionPanel.visible = false

		$Timer.wait_time = timer_wait_time
		$Timer.start()

	else:
		button.visible = false

		lives -= 1
		update_hearts()

		if lives <= 0:
			get_tree().change_scene_to_file("res://GameOver.tscn")

func _process(delta):
	if game_won:
		return

	if !get_tree().paused:
		survival_time += delta

	var time_left = max(0, 60 - int(survival_time))
	$UI/Time/TimerText.text = str(time_left)

	if survival_time >= 60.0 and lives > 0:
		win_game()

func win_game():
	game_won = true

	print("YOU WIN! Survived 60 seconds with ", lives, " lives left.")

	get_tree().paused = true

func update_hearts():
	$UI/Lives/Heart.texture = full_heart if lives >= 1 else empty_heart
	$UI/Lives/Heart2.texture = full_heart if lives >= 2 else empty_heart
	$UI/Lives/Heart3.texture = full_heart if lives >= 3 else empty_heart
