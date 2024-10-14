class_name statics
extends Node

static var can_roll = true
static var doing:bool
static var rolled:bool = false
static var zeroed:bool

static var zminus:bool
static var zplus:bool
static var xminus:bool
static var xplus:bool
#enum corner{} # still evaluating which is best, currently going for dict.
static var double_dict = {0:{xminus:false, xplus:false, zminus:true, zplus:true}, 10:{xminus:false, xplus:false, zminus:true, zplus:true}, 16:{xminus:true, xplus:true, zminus:false, zplus:false}, 22:{xminus:true, xplus:true, zminus:false, zplus:false}} # index 2
static var corner_dict = {0:{xminus:false, xplus:true, zminus:false, zplus:true}, 10:{xminus:true, xplus:false, zminus:true, zplus:false}, 16:{xminus:false, xplus:true, zminus:true, zplus:false}, 22:{xminus:true, xplus:false, zminus:false, zplus:true}} # index 0
static var wall_dict = {0:{xminus:false, xplus:true, zminus:true, zplus:true}, 10:{xminus:true, xplus:false, zminus:true, zplus:true}, 16:{xminus:true, xplus:true, zminus:true, zplus:false}, 22:{xminus:true, xplus:true, zminus:false, zplus:true}} # index 1
static var floor_dict = {0:{xminus:true, xplus:true, zminus:true, zplus:true}, 10:{xminus:true, xplus:true, zminus:true, zplus:true}, 16:{xminus:true, xplus:true, zminus:true, zplus:true}, 22:{xminus:true, xplus:true, zminus:true, zplus:true}} # index 3
# check the player cell item & orientation first, then check for cell item & orientatoin in available direction.

static var colour_dict = {"player":preload("res://material/blue.tres"), "ai_1":preload("res://material/player_green.tres"), "ai_2":preload("res://material/orange.tres"), "ai_3":preload("res://material/yellow.tres")}


static var self_xminus_ok: Signal = (func():
	(statics as Object).add_user_signal("self_xminus_ok")
	return Signal(statics, "self_xminus_ok")).call()

static var self_xplus_ok: Signal = (func():
	(statics as Object).add_user_signal("self_xplus_ok")
	return Signal(statics, "self_xplus_ok")).call()

static var self_zminus_ok: Signal = (func():
	(statics as Object).add_user_signal("self_zminus_ok")
	return Signal(statics, "self_zminus_ok")).call()

static var self_zplus_ok: Signal = (func():
	(statics as Object).add_user_signal("self_zplus_ok")
	return Signal(statics, "self_zplus_ok")).call()

static var rolling: Signal = (func():
	(statics as Object).add_user_signal("rolling")
	return Signal(statics, "rolling")).call()

static var diced: Signal = (func():
	(statics as Object).add_user_signal("diced")
	return Signal(statics, "diced")).call()

#static var num = ["player", "ai_1", "ai_2", "ai_3"]

#static var last_num:String #= statics.num[randi_range(-1, statics.num.size() - 1)]

static var produced: Signal = (func():
	(statics as Object).add_user_signal("produced")
	return Signal(statics, "produced")).call()

static var hstate: Signal = (func():
	(statics as Object).add_user_signal("hstate",[{"name":"hs", "type":"TYPE_STRING"},{"name":"hn", "type":"TYPE_OBJECT"}])
	return Signal(statics, "hstate")).call()

static var tstate: Signal = (func():
	(statics as Object).add_user_signal("tstate",[{"name":"ts", "type":"TYPE_STRING"},{"name":"tn", "type":"TYPE_OBJECT"}])
	return Signal(statics, "tstate")).call()

static var readied: Signal = (func():
	(statics as Object).add_user_signal("readied")
	return Signal(statics, "readied")).call()

static var arrow_clicked: Signal = (func():
	(statics as Object).add_user_signal("arrow_clicked")
	return Signal(statics, "arrow_clicked")).call()

static var moved: Signal = (func():
	(statics as Object).add_user_signal("moved")
	return Signal(statics, "moved")).call()
