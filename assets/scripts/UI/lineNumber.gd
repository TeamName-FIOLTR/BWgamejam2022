extends LineEdit
#this script extends LineEdit in order
#to make a number box selector

class_name NumberBox

export var max_value : int = 1024
export var min_value : int = 200


var numeric_value : int
signal number_changed

var do_input_grab : bool = false


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("text_changed",self,"on_text_changed")
	connect("focus_entered",self,"on_focus_entered")
	connect("focus_exited",self,"on_focus_exited")

func on_focus_entered()->void:
	do_input_grab = true
func on_focus_exited()->void:
	do_input_grab = false
	if not (text as String).is_valid_integer():
		set_number_value(numeric_value)
	else:
		set_number_value(int(text))

func int_clamp(val : int,min_val : int, max_val :int)->int:
	if val < min_val and min_val != -1:
		return min_val
	if val > max_val and max_val != -1:
		return max_val
	return val

func set_number_value(val):
	val = int_clamp(val,min_value,max_value)
	var old_caret = caret_position
	text = str(val)
	caret_position = old_caret - 1
	
	if val != numeric_value:
		numeric_value = val
		emit_signal("number_changed",numeric_value)
	
	
func on_text_changed(new_text)->void:
	if not (new_text as String).is_valid_integer():
		set_number_value(numeric_value)

func _input(event):
	if do_input_grab:
		if event.is_action("ui_up"):
			set_number_value(numeric_value + 1)
		if event.is_action("ui_down"):
			set_number_value(numeric_value - 1)
