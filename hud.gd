extends CanvasLayer

#Notifies main that button has been pressed
signal start_game

var win_text = "YOU WON! Congratulations"
var loss_text = "You Lose. Press Space to try again."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_parent().connect("winstate", _on_win)
	pass # Replace with function body.

func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_win(state):
	if state:
		show_message(win_text)
		show_message(win_text)
	else:
		show_message(loss_text)
	emit_signal("start_game")
	
func _on_start_button_pressed():
	$StartButton.hide()
	$Instructions.hide()
	emit_signal("start_game")

func _on_message_timer_timeout():
	$Message.hide()
