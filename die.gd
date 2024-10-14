extends RigidBody3D
#var game = preload("res://game.gd")
var roll_strength
@onready var start_pos = global_position
@onready var raycasts = $raycasts.get_children()
signal roll_finished(value)

# Called when the node enters the scene tree for the first time.
func _ready():
	#self.position = start_pos
	statics.rolling.connect(dicing)
	print("rid", get_rid())


func dicing():
	print("someting")
	_roll()
	await roll_finished#wait(4.0) # somehow wait doesn't seem to work.
	#freeze = true
	print("r pressed")#get_tree().change_scene_to_file(game)



# physics server is the key! RIGIDBODY IS MANAGED BY PHYSICS SERVER.
func _roll():
	#self.position = start_pos # that
	PhysicsServer3D.body_set_state(get_rid(),PhysicsServer3D.BODY_STATE_TRANSFORM,Transform3D.IDENTITY.translated(start_pos))
	sleeping = false
	freeze = false
	#transform.origin = start_pos # this or that
	linear_velocity = Vector3.ZERO
	angular_velocity = Vector3.ZERO
	var x = randi_range(-10, 10)
	var y = randi_range(-10, 10)
	var z = randi_range(-10, 10)
	set_angular_velocity(Vector3(x, y, z))
	#print("r pressed")#roll_finished(false).emit() # not a fuction.


# Called every frame. 'delta' is the elapsed time since the previous frame.
# for testing purpose.
#func _process(delta):
	#if Input.is_action_just_pressed("a"):
		#_roll()
		#print("a pressed")



#func wait(seconds:float) ->void:
	#await get_tree().create_timer(seconds).timeout


func _on_sleeping_state_changed():
	if sleeping:
		for raycast in raycasts:
			if raycast.is_colliding():
				roll_finished.emit(raycast.opposite_side)
				print("emited")
				statics.diced.emit()
				#statics.can_roll = true
				statics.rolled = true
				print("result = ",raycast.opposite_side)
