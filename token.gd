extends Area2D

var hovered = false
var mouse_pos = null
var value
var operator
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hovered = false
	$Sprite2D.show()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if hovered:
		if Input.is_action_pressed("mouseclick"):
			#print(get_global_mouse_position())
			position = get_global_mouse_position()
			pass
		if Input.is_action_just_released("mouseclick"):
			hovered = false
			pass
		pass
	pass
