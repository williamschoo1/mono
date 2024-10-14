extends GridMap
var gimbal = preload("res://cam_gimbal.tscn")
var token = preload("res://token.tscn")
var bot = preload("res://bot_cam.tscn")
@onready var coor2 = get_used_cells() #this works better
var edge = [
	Vector3(4, 0, -5), Vector3(3, 0, -5), Vector3(2, 0, -5), Vector3(1, 0, -5), Vector3(0, 0, -5), Vector3(-1, 0, -5), Vector3(-2, 0, -5), Vector3(-3, 0, -5), Vector3(-4, 0, -5), Vector3(-5, 0, -5), 
	Vector3(-5, 0, -4), Vector3(-5, 0, -3), Vector3(-5, 0, -2), Vector3(-5, 0, -1), Vector3(-5, 0, 0), Vector3(-5, 0, 1), Vector3(-5, 0, 2), Vector3(-5, 0, 3), Vector3(-5, 0, 4),
	Vector3(4, 0, 4),Vector3(3, 0, 4),Vector3(2, 0, 4),Vector3(1, 0, 4),Vector3(0, 0, 4),Vector3(-1, 0, 4),Vector3(-2, 0, 4),Vector3(-3, 0, 4),Vector3(-4, 0, 4),
	Vector3(4, 0, -4), Vector3(4, 0, -3),Vector3(4, 0, -2),Vector3(4, 0, -1),Vector3(4, 0, 0),Vector3(4, 0, 1),Vector3(4, 0, 2),Vector3(4, 0, 3)
	] # z=-5 draws a horizontal boundery; x=-5 draws a vertical boundery.
# Since the grid is not centred at y, the position must skewed; therefore 5 was abandoned.

var edgev = PackedVector3Array(edge)
var itemindex = randi_range(0, 2)
var ori = [0, 10, 16, 22]

var spawnpoint = [Vector3(-4.5, 0.1, -4.5), Vector3(4.5, 0.1, -4.5), Vector3(4.5, 0.1, 4.5), Vector3(-4.5, 0.1, 4.5)] # array starts from 0
var out = [Vector3(0.5, 0, 0.5), Vector3(-0.5, 0, 0.5), Vector3(0.5, 0, -0.5), Vector3(-0.5, 0, -0.5)] # +-, +-, ++, ++, ++, +-
var astar = AStar3D.new()
var outPos = out[randi() % out.size()]




#func mobility():
	#get_cell_item(call("_ready").player.position)

signal go

@export var pos:int
@export var num = ["player", "ai_1", "ai_2", "ai_3"]
@export var last_num:String
#func get_num() -> String:# this guy run on its own because the condition was met.
	#if num.size() >= 2:#num.shuffle() # not the crash of randomize so shuffle is safe.
		#var last_num = num[randi() % num.size()]
		#num.erase(last_num) # couldn't modulo to size of 1 because it makes it modulo 0 which triggers the modulo zero error.
		#print("num.size =", num.size())
		#return last_num
	#elif num.size() <= 1:
		#var last_num = num[0]
		#print("last_num4 =", last_num)
		#return last_num
	#else:
		#return "null"
#@onready var hs = $indent/h_spawn

signal last_num_produced


# WORK ON THE "GAME" SCENE FOR NOW TO PROVIDE A MINIMUM VIABLE PRODUCT.
# Called when the node enters the scene tree for the first time.
func _ready():
	print(coor2)
	prints("outPos = ", outPos)
	print(spawnpoint[1])
	print(spawnpoint[0])
	#settoken().outPos
	for i in range(spawnpoint.size()):
		pos = i 
		var instance = token.instantiate()
		add_child(instance)
		var array = PackedVector3Array(spawnpoint)
		instance.position = array[i]#Vector3(result.append(spawnpoint[i]))
		last_num = num[randi_range(-1, num.size() - 1)]
		num.erase(last_num)
		print("last_num =", last_num)
		#last_num_produced.emit()
		statics.produced.emit()
		#statics.posPlus.emit()
		#pos = i
		print("posed")
		if last_num == "player":# either line 61 or line 62 has some problem.
			instance.set_script(load("res://player.gd"))
			#instance.call("_ready")
			instance.token_state = last_num
			instance.call("_ready")
			var gimbal_cam = gimbal.instantiate()
			add_child(gimbal_cam)
			gimbal_cam.position = instance.position
			gimbal_cam.reparent(instance)
			gimbal_cam.name = str(last_num) + "_cam"
			#var player = instance
			#return player
			#break
		if last_num.contains("player") == false: 
			instance.set_script(load("res://ai.gd"))
			#instance.call("_ready")
			instance.token_state = last_num
			instance.call("_ready")# consider making them separate threads
			var bot_cam = bot.instantiate()
			add_child(bot_cam)
			bot_cam.position = instance.position
			bot_cam.reparent(instance)
			bot_cam.name = str(last_num) + "_cam" #this is the node3d + camera3d, need to find a way to extract camera.
			print("non-player =", last_num)
			#break
	#spawnpoint.add_child(instance) # nonexsistent function'add_child' in base 'Array'.
	#fourpath()
	#set_cell_item(Vector3(0, 0, 0), 2, 22)  # only shows up one wall. changing orientation from 0 to 22 only changed the direction of the wall not the amount of wall.
	print(edge[13])
	print(edge[22])
	print(edge[32])
	print(edge[35]) # 23 - 6 + 1 = 18(vertical sets of vector), so 40 sets of vector in edge.
	#print(edge[36]) # edge only 36 big
	middle()
	# make astar rotate the next obstical cell item.
	#landscape()
	#var test = token.instantiate()
	#add_child(test)
	#test.position = outPos
	#set_cell_item(local_to_map(outPos),0) # just for test
	#set_cell_item(local_to_map(spawnpoint[0]), 1, 22) # for manually record orientstion # double with ori of 0 is blocking left and right.
	#mobility()
	know_token()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func landscape(): # orientation = 0, 10, 16, 22 for rotation ( 0 = no rotation)
	  # itemindex 0 = "connerin-topless", 1 = "wall-topless", 2 = "doublewall", 3 = "floor-topless".
	for j in range(edgev.size()): #vector3i
		set_cell_item(edgev[j], -1)
		if edgev[j].x in range(0, 5) and itemindex == 0:
			set_cell_item(edgev[j], itemindex, 0) #fix this later at school


func middle() :
	var middlearr = Array(coor2)
	var edgevi = Array(edge, TYPE_VECTOR3I, &"", null)
	for vec in range(edgevi.size()): #range(edge.size()) #vec in edgevi
		print("vec =", edgevi[vec])
		middlearr.remove_at(middlearr.find(edgevi[vec], 0)) # attempt to earse a variable of type 'Vector3' into a TypedArray of type 'Vector3i'.
		print("middlearr.size() = ", middlearr.size())#middlearr.resize(middlearr.size())
	var middleArr = PackedVector3Array(middlearr)
	#var Itemindex = randi_range(0, 3)
	#var rot = ori[randi() % ori.size()]
	for k in range(middleArr.size()):
		var Itemindex = randi_range(0, 3)
		var rot = ori[randi() % ori.size()]
		set_cell_item(middleArr[k], -1)
		set_cell_item(middleArr[k],Itemindex, rot)
		print("Itemindex = ", Itemindex)
		print("rot = ", rot)


func fourpath():
	#astar.add_point(1, spawnpoint[0]) # get closest position in segment after connected.
	#astar.add_point(2, spawnpoint[1])
	#astar.add_point(3, spawnpoint[2])
	#astar.add_point(4, spawnpoint[3])
	#astar.add_point(5, outPos)
	#astar.connect_points(1, 5,)
	#astar.connect_points(2, 5,)
	#astar.connect_points(3, 5,)
	#astar.connect_points(4, 5,)
	for something in range(coor2.size()):
		astar.add_point(something, coor2[something])
		var b = astar.get_point_position(something) # "a" was something.
		print(something, "=", b)
	var cosp1: int = coor2.find(Vector3i(4, 0, -5), 0)
	var cosp2: int = coor2.find(Vector3i(-5, 0, -5), 0)
	var cosp3: int = coor2.find(Vector3i(4, 0, 4), 0)
	var cosp4: int = coor2.find(Vector3i(-5, 0, 4), 0)
	var cosp5: int = coor2.find(Vector3i(outPos), 0)
	astar.connect_points(cosp1, cosp5)
	astar.connect_points(cosp2, cosp5)
	astar.connect_points(cosp3, cosp5)
	astar.connect_points(cosp4, cosp5)
	#get_cell_item(Vector3i(spawnpoint[1]).get_avaiable_point_id().set_surface_material())#if get_cell_item()# int get_available_point_id() # if the mesh = mesh of next position: change material.
	#var path1 = astar.get_id_path(cosp1, cosp5)
	#print("next = ",path1.get_available_ponit_id())

func know_token():
	var tokens = get_children()
	for indication in tokens:
		match indication.token_state:
			"player":
				indication.get_child(0).material_override = statics.colour_dict[indication.token_state]
			"ai_1":
				indication.get_child(0).material_override = statics.colour_dict[indication.token_state]
			"ai_2":
				indication.get_child(0).material_override = statics.colour_dict[indication.token_state]
			"ai_3":
				indication.get_child(0).material_override = statics.colour_dict[indication.token_state]

