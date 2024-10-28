extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	print("cam", get_index(), get_parent().name)





@onready var cam:Camera3D = $happy



# create a plane mesh (make it root) and instatiate token for testing.
func _input(event):
	if Input.is_action_pressed("left_mouse"):
		if event is InputEventMouseMotion:
			rotate(Vector3.UP, -event.relative.x * 0.001)#event.relative.x * 0.001)


func _process(delta):
	#if cam == null:
		#cam = get_child(0)
	if cam.current == true:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

