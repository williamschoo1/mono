extends Node


#signal blah(one, two, tree, four, five)



# density texture for moving up animaton
var token = preload("res://token.tscn")
@onready var instance = token.instantiate()
var where = [Vector3(1, 0, 0), Vector3(1, 2, 0), Vector3(2, 2, 0), Vector3(2, 2, 1), Vector3(2, 2, 2), Vector3(2, 2, 3), Vector3(2, 2, 4), Vector3(2, 2, 5), Vector3(2, 2, 6), Vector3(2, 2, 7), Vector3(2, 2, 8)]
# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(101):
		print(randi_range(0, 5)) # 5 is included.
		i += 1
	#blah.emit(11,22,33,44,55)
	#decrypt2.call() need to call it with args.


func decrypt(a,b,c,d,e):#doesn't work
	await $sig.blah
	print("a = ", a)
	print("a = ", b)
	print("a = ", c)
	print("a = ", d)
	print("a = ", e)

func decrypt1(one,two,three,four,five):
	await $sig.blah
	var a = one
	var b = two
	var c = three
	var d = four
	var e = five
	print(a,b,c,d,e)
	#print("x =", x)

func decrypt2(a,b,c,d,e):
	var z = await $sig.blah
	a = z[0]
	b = z[1]
	c = z[2]
	d = z[3]
	e = z[4]
	print("a:",a,"b:",b,"c:",c,"d:",d,"e:",e)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
