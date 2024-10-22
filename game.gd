extends Node
# press r to roll dice.
# and switch viewport to the token of the turn.
#var diceroll = preload("res://diceroll.tscn") # couldn't think of a way to access scene/node outside of a tree. so use switch_scene.
# NO NEED TO USE SWITCH_SCENE; VIEWPORTS WILL ACHEIVE THE DESIRED EFFECT.
#var h = Human.new()
# CAMERAS ALWAYS DISPLAY ON THE CLOSEST PARENT VIEWPORT!
#@onready var maze = $Node3D/GridMap
#var human_pos = [Vector3(-2.37, 0, 0), Vector3(2.37, 0, 0), Vector3(0, 0, 2.37), Vector3(0, 0, -2.37)]
#var cam_dict = {Vector3(-2.37, 0, 0):-90, Vector3(2.37, 0, 0):90, Vector3(0, 0, 2.37):0, Vector3(0, 0, -2.37):180}
signal last
#var human = preload("res://human.tscn")

@export var player_hcam:Camera3D
@export var ai_1_hcam:Camera3D
@export var ai_2_hcam:Camera3D
@export var ai_3_hcam:Camera3D

@export var player_tcam:Camera3D
@export var ai_1_tcam:Camera3D
@export var ai_2_tcam:Camera3D
@export var ai_3_tcam:Camera3D

#@onready var tokens = $Node3D/GridMap.get_children()
#@onready var humans = $indent/h_spawn.get_children()

# weakref() on statics (signals in particular) should help solving the infinite object problem(debugger -> monitor)
# Otherwise I'll have to figure out a way to call queque_free() or free() on the signal.

func _enter_tree():
	statics.tstate.connect(no_iterate)
	statics.hstate.connect(h_match)
	statics.moved.connect(counting)
	last.connect(turn_changed)
	statics.doing = false
	#corder = corder.append_array(order)
	#pass

func _input(event):
	if Input.is_action_pressed("r") and statics.can_roll == true:
		statics.can_roll = false
		#get_tree().change_scene_to_file(diceroll)
		statics.rolling.emit()
		print("rolling")
		#await statics.diced # doesn't help; need to disable input.
		#print("diced")

func _ready():
	print("game says hello")#printed at last of course.
	print("order =", last_turn)#this is printing empty because the elements were deleted four times, without the fifth call the refill will not trigger.
	#corder = corder.append_array(order)
	switch_turn()
	#perspective()
	#await get_tree().process_frame
	#alternative()
	#alt couldn't reference everthimg even when token cam is 1.
	#switch_turn()
	print("after switch =", last_turn)
	await get_tree().process_frame
	perspective()
	print("waited")

# match might be the problem.//if statement couldn't fix them.
#func alternative():
	#var tokens = $Node3D/GridMap.get_children()
	#var humans = $indent/h_spawn.get_children()
	#for t in tokens:
		#switch_turn()
		#print("alt")
		#if t.token_state == "player" and last_turn[0] == "player":
			#player_tcam = t.get_child(1).get_child(0)
		#if t.token_state == "ai_1" and last_turn[0] == "ai_1":
			#ai_1_tcam = t.get_child(1).get_child(0)
		#if t.token_state == "ai_2" and last_turn[0] == "ai_2":
			#ai_2_tcam = t.get_child(1).get_child(0)
		#if t.token_state == "ai_3" and last_turn[0] == "ai_3":
			#ai_3_tcam = t.get_child(1).get_child(0)
		#match last_turn[0]:
			#"player":
				#if t.token_state == last_turn[0]:
					#player_tcam = t.get_child(1).get_child(0)
			#"ai_1":
				#if t.token_state == last_turn[0]:
					#ai_1_tcam = t.get_child(1).get_child(0)
			#"ai_2":
				#if t.token_state == last_turn[0]:
					#ai_2_tcam = t.get_child(1).get_child(0)
			#"ai_3":
				#if t.token_state == last_turn[0]:
					#ai_3_tcam = t.get_child(1).get_child(0)
	#print("t")
	#for h in humans:
		#switch_turn()
		#match last_turn[0]:
			#"player":
				#if h.human_state == last_turn[0]:
					#player_hcam = h.get_child(1)
			#"ai_1":
				#if h.human_state == last_turn[0]:
					#ai_1_hcam = h.get_child(1)
			#"ai_2":
				#if h.human_state == last_turn[0]:
					#ai_2_hcam = h.get_child(1)
			#"ai_3":
				#if h.human_state == last_turn[0]:
					#ai_3_hcam = h.get_child(1)



# SCENES ARE CREATED IN BOTTOM-TO-TOP ORDER, THEREFORE READY FUNCTION IS CALLED IN THAT ORDER.
var order = ["ai_3", "ai_2", "ai_1", "player"]
var last_turn = []
var corder = []
var state:String
var node:Object

#var semaphore = Semaphore.new() #didn't work as expected.
var mutex = Mutex.new() #doesn't change any order of execution.

#player_tcam = tn.get_child(1).get_child(0)
func no_iterate(ts, tn:CharacterBody3D):
	match ts:
		"player":
			player_tcam = tn.get_child(2).get_child(0)
		"ai_1":
			ai_1_tcam = tn.get_child(2).get_child(0)
		"ai_2":
			ai_2_tcam = tn.get_child(2).get_child(0)
		"ai_3":
			ai_3_tcam = tn.get_child(2).get_child(0)


# if a signal is defined with argument, emitting it with value will make the function take the argument in?(BY NAME OR BY ORDER?) positional arguments.
# player -> ai_1 -> ai_2 -> ai_3
#func get_reference(ts, tn):
	#statics.doing = true
	#print("first line")
	#print("ts =", ts)
	#print("tn =", tn)
	#await statics.readied
	#mutex.lock()
	#switch_turn()
	#print("varify")
	#print(last_turn)
	#match last_turn[0]:
		#"player":
			#if state.contains(last_turn[0]) and ts.contains(last_turn[0]):
				#player_tcam = tn.get_child(1).get_child(0)# was tn.get_child(0).get_child(0)
				#player_hcam = node.get_child(1)
				#print("referenced")
			#else:
				#print("missed")
		#"ai_1":
			#if state.contains(last_turn[0]) and ts.contains(last_turn[0]):
				#ai_1_tcam = tn.get_child(1).get_child(0)
				#player_hcam = node.get_child(1)
				#print("referenced")
			#else:
				#print("missed")
		#"ai_2":
			#if state.contains(last_turn[0]) and ts.contains(last_turn[0]):
				#ai_2_tcam = tn.get_child(1).get_child(0)
				#player_hcam = node.get_child(1)
				#print("referenced")
			#else:
				#print("missed")
		#"ai_3":
			#if state.contains(last_turn[0]) and ts.contains(last_turn[0]):
				#ai_3_tcam = tn.get_child(1).get_child(0)
				#player_hcam = node.get_child(1)
				#print("referenced")
			#else:
				#print("missed")
	#print("matching")
	#mutex.unlock()
	#statics.doing = false


func switch_turn():
	if corder.size() == 0:
		corder.append_array(order)
	print("corder =", corder)
	last_turn.resize(0)
	#var coder = order.duplicate()
	last_turn.resize(1)
	last_turn.fill(corder[-1])
	#last_turn.append(corder[-1])
	corder.erase(last_turn[0])
	print("switching")
	#return last

#USE ARRAY.CONTAINS(LAST_TURN) TO TURN ON THE CAMERA.
func h_match(hs, hn):
	print("hs =", hs)
	match hs:
		"player":
			player_hcam = hn.get_child(1)
		"ai_1":
			ai_1_hcam = hn.get_child(1)
		"ai_2":
			ai_2_hcam = hn.get_child(1)
		"ai_3":
			ai_3_hcam = hn.get_child(1)

#func h_output(a, b):
	#print("a =", a)
	#state = a
	#print("b =", b)
	#node = b
	#statics.readied.emit()

#func human_state_change():
	#human.human_state = statics.last_num
# Called every frame. 'delta' is the elapsed time since the previous frame.

var turn_tcam:Camera3D
var turn_hcam:Camera3D

func perspective():
	print("unauthorised")
	match last_turn[0]:
		"player":
			turn_hcam = player_hcam
			print("i do next")
			turn_tcam = player_tcam
		"ai_1":
			turn_hcam = ai_1_hcam
			turn_tcam = ai_1_tcam
		"ai_2":
			turn_hcam = ai_2_hcam
			turn_tcam = ai_2_tcam
		"ai_3":
			turn_hcam = ai_3_hcam
			turn_tcam = ai_3_tcam
	turn_hcam.current = true


@onready var die_cam = $Node3D2/Camera3D

#the best way is probably keep awaiting
func _process(delta):
	#print("first")
	if turn_hcam.current == true:
		$ui/hints.visible = true
	else: $ui/hints.visible = false
	if statics.rolled == true:
		#perspective()
		turn_tcam.current = true
	if statics.count == 0 and statics.rolled == true:
		statics.rolled = false
		statics.zeroed = true
		#when count reaches 0, there will be no forced current on tcam, which can then give current back to hcam.
		statics.can_roll = true
		last.emit()

#var count:int

func _on_die_roll_finished(value):
	statics.count = value
	statics.zeroed = false
	$ui/step_count.text = str(statics.count)

func counting():
	if statics.count >= 1:
		statics.count = statics.count - 1
		$ui/step_count.text = str(statics.count)

func turn_changed():
	switch_turn()
	perspective()
