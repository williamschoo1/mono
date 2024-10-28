extends Area3D

var characters:Array[CharacterBody3D] = []

# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().process_frame
	# funny enough I used parent instead of owner, which never gets me what I want.
	var par = owner
	var ent = par.get_parent()
	var sib = ent.get_children()
	var c = ent.get_child_count()
	print("owner of area's index = ", owner.get_index())
	print("c = ", c)
	print("sib =", sib)
	characters.resize(4)
	for i in range(get_index(), characters.size()):
		print("area i = ", i)
		characters[i] = sib[i]
		print(characters)
	body_entered.connect(_on_body_entered)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	print(body.name,"entered")
	statics.finished.emit()



#func request_confirmation(thing):
	#print("wait for a bit")
	#await get_tree().create_timer(0.2).timeout
	#if characters.has(thing) == true and self.overlaps_body(thing) == true:
		#if overlaps_body(thing):
			#print("confirmed")
			#return true


func _on_body_exited(body):
	print(body.name, "exited")
