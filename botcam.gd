extends Camera3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if self.current == true:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
