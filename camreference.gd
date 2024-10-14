extends Camera3D
@onready var token = get_node("/root/token")
# this script is just for reference it has not been implemented in the game.



# Called when the node enters the scene tree for the first time.
func _ready():
	look_at(token.position)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event):
	#if event is InputEventMouseMotion:
		#if event.button_mask == MOUSE_BUTTON_MASK_LEFT:
			#if event.relative.x >= 0:
				#rotation_degrees.y += 1
				#print("positive")
			#elif event.relative.x <= -0:
				#rotation_degrees.y -= 1
				#print("negative")
	if Input.is_action_pressed("left_mouse"):
		if event is InputEventMouseMotion:
			rotate(Vector3.UP, event.relative.x * 0.001)
