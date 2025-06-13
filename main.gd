extends Node


@export var token_scene: PackedScene
var token_count = 0
var result_list
var die_faces
signal winstate


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$die.hide()
	die_faces = [$DieFace1, $DieFace2, $DieFace3, $DieFace4, $DieFace5, $DieFace6]
	$die.connect("roll_accepted", _on_roll_accepted)
	$HUD.connect("start_game", _on_start_game)
	pass # Replace with function body.

func _on_roll_accepted(die_value):
	#print("main")
	#print(die_value)
	track_results(die_value)
	generate_token()
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_start_game():
	$die.show()
	$die.start($StartPosition.position)
	result_list = []
	for die_face in die_faces:
		die_face.modulate.a = 0.25
	
func track_results(i):
	if i in result_list:
		emit_signal("winstate", 0)
		#print(result_list)
	else:
		result_list.append(i)
		die_faces[i].modulate.a = 1
	if len(result_list) == 6:
		emit_signal("winstate", 1)
		#print(result_list)
	pass
	
func generate_token():
	var token = token_scene.instantiate()
	var token_location = Vector2(800, 50 + (token_count * 100))
	token_count += 1
	token.value = 1
	token.operator = "+"
	token.position = token_location
	add_child(token)
