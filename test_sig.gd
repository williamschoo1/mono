extends Node3D

signal blah(one, two, tree, four, five)
# Called when the node enters the scene tree for the first time.
func _ready():
	blah.emit(11,22,33,44,55)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
