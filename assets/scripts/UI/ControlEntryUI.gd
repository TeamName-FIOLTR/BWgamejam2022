extends Control

class_name UIControlMapEntry

export var lbl_control_path : NodePath
onready var lbl_control : Label = get_node(lbl_control_path) as Label

export var lbl_current_control_path : NodePath
onready var lbl_current_control : Label = get_node(lbl_current_control_path) as Label

signal change_ui_wanted

func load_action(act : String)->void:
	lbl_control.text = act.replace("_"," ")
	#one control per action
	lbl_current_control.text = (InputMap.get_action_list(act)[0] as InputEvent).as_text()


func _on_ChangeBtn_pressed():
	emit_signal("change_ui_wanted",lbl_control.text.replace(" ","_"))
