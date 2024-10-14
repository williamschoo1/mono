extends Node3D

#@export var pos:int = 0
#@onready var maze = $"../../Node3D/GridMap"
var human_pos = [Vector3(-2.37, 0, 0), Vector3(2.37, 0, 0), Vector3(0, 0, 2.37), Vector3(0, 0, -2.37)]
var cam_dict = {Vector3(-2.37, 0, 0):-90, Vector3(2.37, 0, 0):90, Vector3(0, 0, 2.37):0, Vector3(0, 0, -2.37):180}

var human = preload("res://human.tscn")


var working:bool = false

func _enter_tree():
	statics.produced.connect(h)
	#statics.produced.connect(_ready) # the for loop is causing too much instantiation.

# this works.
#func water():
	#print("water")


#func wait():
	#await working == false
#func spw(a):
	#return a

# coroutine needed in order for await to stop the code from running.
func h():
	#await wait()
	#working = true
	var human_ins = human.instantiate()
	add_child(human_ins)
	var maze = $"../../Node3D/GridMap"
	human_ins.position = human_pos[maze.pos]
	human_ins.human_state = maze.last_num
	print("state setted")
	var human_cam = Camera3D.new()#was nuder if.
	human_cam.far = 7
	human_cam.position = Vector3(human_ins.position.x, human_ins.position.y + 1.5, human_ins.position.z)
	add_child(human_cam) 
	human_cam.reparent(human_ins)
	if human_ins.human_state.contains("player"):
		human_cam.set_script(load("res://cam_gimbal.gd"))
	human_ins.rotation.y = deg_to_rad(cam_dict[human_pos[maze.pos]])
	#pos + 1
	#working = false


# currently couldn't find a way to disable _ready.
func _ready():
	var spawn = get_children()
	for man in spawn:#human
		print("human.position = ", man.position)
		match man.human_state:
			"player":
				man.get_child(0).material_override = statics.colour_dict[man.human_state]
			"ai_1":
				man.get_child(0).material_override = statics.colour_dict[man.human_state]
			"ai_2":
				man.get_child(0).material_override = statics.colour_dict[man.human_state]
			"ai_3":
				man.get_child(0).material_override = statics.colour_dict[man.human_state]
		#get_child(index); mesh is first child so index = 0.



	#for pos in human_pos:
		#var human_ins = human.instantiate()
		#add_child(human_ins)
		#human_ins.position = pos
		#human_ins.human_state = maze.last_num
		#print("state setted")
		#await maze.last_num_produced
		#if human_ins.human_state.contains("player"):
			#var human_cam = Camera3D.new()
			#human_cam.position = Vector3(pos.x, pos.y + 1.5, pos.z)
			#add_child(human_cam)
			#human_cam.reparent(human_ins)
			#human_cam.set_script(load("res://cam_gimbal.gd"))
		#human_ins.rotation.y = deg_to_rad(cam_dict[pos])
		#await maze.last_num_produced
# copied from game.gd just for it to work.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
