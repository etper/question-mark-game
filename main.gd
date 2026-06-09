extends Node2D

var paused_now = false

func _ready():
	$Timer.wait_time = 10.0
	$Timer.start()

func _on_timer_timeout():
	if paused_now:
		get_tree().paused = false
		$Timer.wait_time = 10.0
	else:
		get_tree().paused = true
		$Timer.wait_time = 2.0

	paused_now = !paused_now
	$Timer.start()
