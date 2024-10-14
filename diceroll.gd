extends Node3D

@onready var die = $Die
@onready var die_cam = $Camera3D
# Called when the node enters the scene tree for the first time.
func _ready():
	die.roll_finished.connect(unsee)
	#statics.rolling.connect(see)# if the connect() couldn't connect 2 then disabling it should fix.
	#pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	see()

func see():
	await statics.rolling
	die_cam.current = true

func unsee(number):
	wait(1)
	die_cam.current = false
	print("unsee")


func wait(seconds:float) ->void:
	await get_tree().create_timer(seconds).timeout
