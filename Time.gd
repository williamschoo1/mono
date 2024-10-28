extends Timer


# Called when the node enters the scene tree for the first time.
func _ready():
	for i in 10:
		print(i)
	self.paused = true
	standard_deviation.paused = true

var current_time:float
var next_time:float

var stored_time:float = 0.1

@onready var standard_deviation = $standard

func _process(delta):
	#print(time_left)
	#start()
	#was time_left >= 0
	if time_left > 0: #or statics.count >= 0.1:
		print(time_left)
		print("standard =", stored_time)
		if stored_time == 0 and statics.count >= 0.1:
			standard_deviation.start()
		if Input.is_action_pressed("a") == true:
			self.paused = false
			standard_deviation.paused = false
			#standard_deviation.start(stored_time)
		elif Input.is_action_just_released("a") == true:
			#standard_deviation.stop()
			stored_time = standard_deviation.time_left
			standard_deviation.paused = true
			self.paused = true
		if Input.is_action_pressed("w") == true:
			self.paused = false
			standard_deviation.paused = false
			#standard_deviation.start(stored_time)
		elif Input.is_action_just_released("w") == true:
			#standard_deviation.stop()
			stored_time = standard_deviation.time_left
			standard_deviation.paused = true
			self.paused = true
		if Input.is_action_pressed("s") == true:
			self.paused = false
			standard_deviation.paused = false
			#standard_deviation.start(stored_time)
		elif Input.is_action_just_released("s") == true:
			#standard_deviation.stop()
			stored_time = standard_deviation.time_left
			standard_deviation.paused = true
			self.paused = true
		if Input.is_action_pressed("d") == true:
			self.paused = false
			standard_deviation.paused = false
			#standard_deviation.start(stored_time)
		elif Input.is_action_just_released("d") == true:
			#standard_deviation.stop()
			stored_time = standard_deviation.time_left
			standard_deviation.paused = true
			self.paused = true
