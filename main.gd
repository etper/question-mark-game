extends Node2D

var paused_now = false

var questions = [
	"What is 2 + 2?",
	"What color is the sky?"
]

func _ready():
	$QuestionPanel.visible = false

	$Timer.wait_time = 1.0
	$Timer.start()

func _on_timer_timeout():
	if paused_now:
		get_tree().paused = false
		$QuestionPanel.visible = false
		$Timer.wait_time = 10.0
	else:
		get_tree().paused = true

		var q = questions.pick_random()
		$QuestionPanel/QuestionLabel.text = q
		$QuestionPanel.visible = true

	paused_now = !paused_now
	$Timer.start()
