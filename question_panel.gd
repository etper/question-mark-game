extends Panel

signal answer_selected(answer)

func setup(question_data):
	$QuestionLabel.text = question_data["question"]

	var choices = question_data["choices"]

	$AnswerButton1.text = choices[0]
	$AnswerButton2.text = choices[1]
	$AnswerButton3.text = choices[2]

func _on_answer_button_1_pressed():
	answer_selected.emit($AnswerButton1.text)

func _on_answer_button_2_pressed():
	answer_selected.emit($AnswerButton2.text)

func _on_answer_button_3_pressed():
	answer_selected.emit($AnswerButton3.text)
