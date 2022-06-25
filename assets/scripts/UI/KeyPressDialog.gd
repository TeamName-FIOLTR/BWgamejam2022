extends ConfirmationDialog

class_name ActionMapDialog

export var default_text : String = "press any key..."


signal update_action

var to_add : InputEvent setget set_to_add,get_to_add
func set_to_add(val : InputEvent)->void:
	to_add = val
	$ButtonPressed.text = val.as_text()
func get_to_add()->InputEvent:
	return to_add

var action : String setget set_action,get_action
func set_action(val : String)->void:
	action = val
	window_title = "press a key to set " + action
	$ButtonPressed.text = default_text
func get_action()->String:
	return action

func _on_KeyPressDialog_confirmed():
	InputMap.action_erase_events(self.action)
	InputMap.action_add_event(self.action,self.to_add)
	
	Globals.config_data.input_map = ConfigResource.encode_input_map()
	Globals.save_config()
	
	$ButtonPressed.text = default_text
	emit_signal("update_action",self.action)

func _ready():
	$ButtonPressed.text = default_text

func _input(event):
	if visible and not event is InputEventMouse:
		self.to_add = event
