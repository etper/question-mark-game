extends Panel

signal answer_selected(answer)

func setup(question_data):
	$AnswerButton1.visible = true
	$AnswerButton2.visible = true
	$AnswerButton3.visible = true

	$QuestionLabel.text = question_data["question"]

	var choices = question_data["choices"].duplicate()
	choices.shuffle()

	$AnswerButton1.text = choices[0]
	$AnswerButton2.text = choices[1]
	$AnswerButton3.text = choices[2]

func _on_answer_button_1_pressed():
	answer_selected.emit($AnswerButton1.text, $AnswerButton1)

func _on_answer_button_2_pressed():
	answer_selected.emit($AnswerButton2.text, $AnswerButton2)

func _on_answer_button_3_pressed():
	answer_selected.emit($AnswerButton3.text, $AnswerButton3)
