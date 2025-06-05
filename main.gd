extends Node

var result_list
var die_faces

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	die_faces = [$DieFace1, $DieFace2, $DieFace3, $DieFace4, $DieFace5, $DieFace6]
	new_game()
	$die.connect("roll_accepted", _on_roll_accepted)
	pass # Replace with function body.

func _on_roll_accepted(die_value):
	#print("main")
	#print(die_value)
	track_results(die_value)
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func new_game():
	$die.start($StartPosition.position)
	result_list = []
	for die_face in die_faces:
		die_face.modulate.a = 0.25
	
func track_results(i):
	if i in result_list:
		print("lose")
		print(result_list)
		new_game()
	else:
		result_list.append(i)
		die_faces[i].modulate.a = 1
	if len(result_list) == 6:
		print("win")
		print(result_list)
	pass
	
func win():
	pass
	
func lose():
	pass
	
	
