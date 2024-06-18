extends GridMap

var coor2 = get_used_cells() #this works better
# Called when the node enters the scene tree for the first time.
func _ready():
	print(coor2)
	return coor2


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
