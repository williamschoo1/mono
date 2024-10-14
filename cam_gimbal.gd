extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	print("cam", get_index(), get_parent().name)


# Called every frame. 'delta' is the elapsed time since the previous frame.


# create a plane mesh (make it root) and instatiate token for testing.
func _input(event):
	if Input.is_action_pressed("left_mouse"):
		if event is InputEventMouseMotion:
			rotate(Vector3.UP, -event.relative.x * 0.001)#event.relative.x * 0.001)



