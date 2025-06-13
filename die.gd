extends Area2D


signal roll_accepted
var roll_accepted_bool
var rng = RandomNumberGenerator.new()
@export var speed = 1500
var screen_size
var velocity
var board_size_x = 512
var board_size_y = 512
var roll_completed
var roll_time = 1.5
var die_value



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size
	velocity = Vector2.ZERO
	roll_completed = true
	roll_accepted_bool = true
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#Input.is_action_just_pressed("roll")
	if Input.is_action_just_pressed("roll") and roll_completed and roll_accepted_bool: #spacebar
		$WaitTimer.start(roll_time + 1)
		roll_completed = false
		roll_die()
		calculate_trajectory()
	
	if Input.is_action_just_pressed("roll") and not roll_accepted_bool and is_valid_die_result(str(die_value)):
		roll_accepted_bool = true
		#print(roll_completed)
		#print("emitting signal")
		emit_signal("roll_accepted", die_value)
	
	position += velocity * delta * ($RollTimer.time_left / roll_time)
	
func roll_die() -> void:
	$AnimatedSprite2D.show()
	$AnimatedSprite2D.play("roll")
	$RollTimer.start(roll_time)

func _on_roll_timer_timeout() -> void:
	$RollTimer.stop()
	stop_moving()
	roll_completed = true
	roll_accepted_bool = false
	die_value = rng.randi_range(0,5)
	#print(i)
	show_die_face(die_value)

func show_die_face(i):
	$AnimatedSprite2D.play("result", 0)
	$AnimatedSprite2D.set_frame_and_progress(i, 0.0)

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
	pass

func calculate_trajectory() -> void:
	if not roll_completed:
		var valid_range_x = [((board_size_x/2) - (board_size_x/4)), ((board_size_x/2) + (board_size_x/4))]
		var valid_range_y = [((board_size_y/2) - (board_size_y/4)), ((board_size_y/2) + (board_size_y/4))]
		var x_point = rng.randi_range(valid_range_x[0], valid_range_x[1])
		var y_point = rng.randi_range(valid_range_y[0], valid_range_y[1])
		stop_moving()
		velocity.x += x_point - position.x
		velocity.y += y_point - position.y
		if velocity.length() > 0:
			velocity = velocity.normalized() * speed

func stop_moving():
	velocity.x = 0
	velocity.y = 0

func is_valid_die_result(string):
	var regex = RegEx.new()
	regex.compile("[0-5]")
	if regex.search(string):
		return true
	else:
		return false

func _on_body_entered(body: Node) -> void:
	print("collided")
	if body is TileMapLayer:
		#print(velocity.x, velocity.y)
		#print(position.round())
		calculate_trajectory()
		#print("Collided")
		#print(velocity.x, velocity.y)
	else:
		pass

func _on_area_entered(area) -> void:
	print("area collision")
	pass
