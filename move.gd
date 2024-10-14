extends Camera3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("a"):
		position.x += 0.2
	if Input.is_action_pressed("d"):
		position.x -= 0.2
	if Input.is_action_pressed("s"):
		position.z += 0.2
	if Input.is_action_pressed("w"):
		position.z -= 0.2
