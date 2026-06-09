extends Node2D

var lives = 3

var timer_wait_time = 1.0

var questions = [
	{
		"question": "What is 2 + 2?",
		"answer": "4"
	},
	{
		"question": "What color is the sky?",
		"answer": "blue"
	}
]

var current_answer = ""

func _ready():
	$QuestionPanel.visible = false

	# Allows the panel to still work while the game is paused
	$QuestionPanel.process_mode = Node.PROCESS_MODE_ALWAYS

	$Timer.wait_time = timer_wait_time
	$Timer.start()


func _on_timer_timeout():
	var q = questions.pick_random()

	$QuestionPanel/QuestionLabel.text = q["question"]
	current_answer = q["answer"].to_lower()

	$QuestionPanel/AnswerInput.text = ""
	$QuestionPanel.visible = true

	get_tree().paused = true


func _on_submit_button_pressed():
	var player_answer = $QuestionPanel/AnswerInput.text.strip_edges().to_lower()

	if player_answer == current_answer:
		print("Correct!")

		get_tree().paused = false
		$QuestionPanel.visible = false

		$Timer.wait_time = timer_wait_time
		$Timer.start()

	else:
		lives -= 1

		print("Wrong! Lives left: ", lives)

		if lives <= 0:
			print("Game Over")
			get_tree().quit()

		$QuestionPanel/AnswerInput.text = ""
