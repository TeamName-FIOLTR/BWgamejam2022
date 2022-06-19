extends LineEdit

class_name LineEditHint

var hint_text : String = "null"
var hinting : bool = true setget set_hinting,get_hinting
func set_hinting(val : bool)->void:
	if val:
		text = hint_text
	elif text == hint_text:
		text = ""
	hinting = val
func get_hinting()->bool:
	return hinting

func _ready():
	hint_text = text
	connect("focus_entered",self,"on_focus_in")
	connect("focus_exited",self,"on_focus_out")

func on_focus_in():
	self.hinting = false
func on_focus_out():
	if text == "" or text == hint_text:
		self.hinting = true
