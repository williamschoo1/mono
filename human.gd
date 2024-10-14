
extends Node3D

#@onready var human_cam = $MeshInstance3D/Camera3D
@export var human_state:String

# THIS IS FOR ALL FOUR!
#var hmutex = Mutex.new()# probably not humans' fault
#
# Called when the node enters the scene tree for the first time.
func _ready():
	#human_cam.current = true # camera works as expected.
	#hmutex.lock()
	#print(human_state)
	#statics.readied.emit()
	# Signal the state to the 'game' and call player from there. Root node was created at last so use call_deffered.
	#something like (func(): signal.emit()).call_deffered()
	#await get_tree().process_frame
	statics.hstate.emit(human_state, self)# consider making them separate threads
	#print("hsed")
	#hmutex.unlock()
	#print(await statics.hstate)
	# all problem is due to the unnecessary complexity of 'get_reference' in game.gd

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
