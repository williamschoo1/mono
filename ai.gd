extends Node

@export var token_state:String
#var aimutex = Mutex.new()
#var semaphore = Semaphore.new()
#var aithread = Thread.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().process_frame
	statics.tstate.emit(token_state, self)
	#aithread.start(aith,Thread.PRIORITY_NORMAL)
#
#
#func aith():
	#semaphore.wait()
	#await get_tree().process_frame
	#statics.tstate.emit(token_state, self)
#
#func id():
	#if aithread.is_alive() == true:
		#print(aithread.get_id())
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#if statics.doing == false:
		#semaphore.post()
