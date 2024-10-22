extends CharacterBody3D
#var maze = preload("res://maze.tscn")
#var maze_ins = maze.instantiate()
#var parent = preload("res://token.tscn")

@export var token_state:String
# Called when the node enters the scene tree for the first time.
func _ready():
	#statics.self_xminus_ok.connect(check_xminus)
	#statics.self_xplus_ok.connect(check_xplus)
	#statics.self_zminus_ok.connect(check_zminus)
	#statics.self_zplus_ok.connect(check_zplus)
	#statics.arrow_clicked.connect(clicked)
	#grid()
	await get_tree().process_frame
	statics.tstate.emit(token_state, self)
	arm = get_child(2)
	set_physics_process(true)

#abs(turner.position - clicked.position) Use this to determine the direction going to tween to?

# ALWAYS CHECK TWICE.

@onready var grid = get_parent()#this should be '..' which means parent.but will do it later.

#count decrease per press
var speed:int = 4
var acceleration:int = 5
var target_velocity:Vector3 = Vector3.ZERO
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _physics_process(delta):
	#var direction = Vector3.ZERO
	#if Input.is_action_just_pressed("a"):
		#direction.x += 1
		#print("a")
	#if Input.is_action_just_pressed("d"):
		#direction.x -= 1
		#print("d")
	#if Input.is_action_just_pressed("s"):
		#direction.z += 1
	#if Input.is_action_just_pressed("w"):
		#direction.z -= 1
	#if direction != Vector3.ZERO:
		#direction = direction.normalized()
	#target_velocity.x = direction.x * speed
	#target_velocity.z = direction.z * speed
	#velocity = target_velocity
	#move_and_slide()
	# above code provides rectagular movement that does not follow the perspective.
	#velocity.y += -gravity * delta
	get_move_input(delta)
	move_and_slide()

var arm:Node3D


func get_move_input(delta):
	velocity.y = 0
	var input = Input.get_vector("a","d","w","s")
	var dir = Vector3(input.x, 0, input.y).rotated(Vector3.UP, arm.rotation.y)
	velocity = lerp(velocity, dir * speed, acceleration * delta)
	velocity.y = 0
	#with them the y seems to descend each time
	#var dir = Vector3(input.x, 0, input.y)
	#velocity = dir











#func grid():
	#gridmap = get_tree().get_root().get_node("GridMap")
	#return gridmap
#var gridmap = get_tree().get_node("/root/Node3D/GridMap") # No need to load the scene as the script will entre the same scene of maze.
# this caused the maze somehow not running. # I FORGOT TO ADD '/' BEFORE 'ROOT'
#var gridmap = maze_ins.get_node("/root/Node3D/GridMap") # works when first loaded after the game stoped due to errors. NEED BETTER EXPRESSION.
#@onready var gridmap = $maze_ins/Node3D/GridMap # something to do with relaps ?
#get_cell_item()

#var selfpos:Vector3i #= grid.local_to_map(self.position)
#var item_index:int #= grid.get_cell_item(selfpos)
#var orient:int #= grid.get_cell_item_orientation(selfpos)
# SOMEHOW PUTTING THEM IN A FUNCTION AND MANUALLY DECLARE THEM IN 'SET_ARROW' WORKS.
#var selfpos:Vector3i = grid().local_to_map(self.position)
#var item_index:int = grid().get_cell_item(selfpos)
#var orient:int = grid().get_cell_item_orientation(selfpos)

#var x_minus:Vector3i
#var x_plus:Vector3i
#var z_minus:Vector3i
#var z_plus:Vector3i

#func mobility(_item_index, _orient):
	#match _item_index:
		#0:
			#return statics.corner_dict[_orient]
		#1:
			#return statics.wall_dict[_orient]
		#2:
			#return statics.double_dict[_orient]
		#3:
			#return statics.floor_dict[_orient]
#
#var arrow = preload("res://arrow.tscn")
#
#
#func set_arrow():
	#selfpos = grid.local_to_map(self.position)
	#item_index = grid.get_cell_item(selfpos)
	#orient = grid.get_cell_item_orientation(selfpos)
	#x_minus = grid.local_to_map(Vector3(self.position.x - 1, self.position.y, self.position.z))
	#x_plus = grid.local_to_map(Vector3(self.position.x + 1, self.position.y, self.position.z))
	#z_minus = grid.local_to_map(Vector3(self.position.x, self.position.y, self.position.z - 1))
	#z_plus = grid.local_to_map(Vector3(self.position.x, self.position.y, self.position.z + 1))
	#if mobility(item_index, orient)[statics.xminus] == true:
		#statics.self_xminus_ok.emit() # don't connect to arrow because it has not enter the scene yet.
	#if mobility(item_index, orient)[statics.xplus] == true:
		#statics.self_xplus_ok.emit()
	#if mobility(item_index, orient)[statics.xminus] == true:
		#statics.self_xminus_ok.emit()
	#if mobility(item_index, orient)[statics.xminus] == true:
		#statics.self_xminus_ok.emit()
#
#func check_xminus():
	#x_minus = grid.local_to_map(Vector3(self.position.x - 1, self.position.y, self.position.z))
	#var xminus_index = grid.get_cell_item(x_minus)
	#var xminus_orient = grid.get_cell_item_orientation(x_minus)
	#if mobility(xminus_index, xminus_orient)[statics.xplus] == true:
		#var arrow_ins = arrow.instantiate()
		#add_child(arrow_ins)
		#arrow_ins.position = Vector3(self.position.x - 0.5, self.position.y, self.position.z)
		#arrow_ins.add_to_group("arrows")
#
#func check_xplus():
	#x_plus = grid.local_to_map(Vector3(self.position.x + 1, self.position.y, self.position.z))
	#var xplus_index = grid.get_cell_item(x_plus)
	#var xplus_orient = grid.get_cell_item_orientation(x_plus)
	#if mobility(xplus_index, xplus_orient)[statics.xminus] == true:
		#var arrow_ins = arrow.instantiate()
		#add_child(arrow_ins)
		#arrow_ins.position = Vector3(self.position.x + 0.5, self.position.y, self.position.z)
		#arrow_ins.add_to_group("arrows")
#
#func check_zminus():
	#z_minus = grid.local_to_map(Vector3(self.position.x, self.position.y, self.position.z - 1))
	#var zminus_index = grid.get_cell_item(z_minus)
	#var zminus_orient = grid.get_cell_item_orientation(z_minus)
	#if mobility(zminus_index, zminus_orient)[statics.zplus] == true:
		#var arrow_ins = arrow.instantiate()
		#add_child(arrow_ins)
		#arrow_ins.position = Vector3(self.position.x, self.position.y, self.position.z - 0.5)
		#arrow_ins.add_to_group("arrows")
#
#func check_zplus():
	#z_plus = grid.local_to_map(Vector3(self.position.x, self.position.y, self.position.z + 1))
	#var zplus_index = grid.get_cell_item(z_plus)
	#var zplus_orient = grid.get_cell_item_orientation(z_plus)
	#if mobility(zplus_index, zplus_orient)[statics.zminus] == true:
		#var arrow_ins = arrow.instantiate()
		#add_child(arrow_ins)
		#arrow_ins.position = Vector3(self.position.x, self.position.y, self.position.z + 0.5)
		#arrow_ins.add_to_group("arrows")
#
#
#func clicked(pos):
	#self.position = pos
	#get_tree().call_group("arrows", "queue_free")
	#no_arrow = true
	#statics.moved.emit()
#
#
#
#var no_arrow:bool = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#if no_arrow == true and statics.zeroed == false:
		#set_arrow()
		#no_arrow = false
