extends ScrollContainer

#generic UI node that picks a save to load

#you can overide the get_objects function to populate the
#ui with buttons selecting different objects

class_name SavePicker

export var vbContainer : NodePath
onready var btnSaveContainer : VBoxContainer = get_node(vbContainer)

signal save_pressed


func get_selectable_objects():
	return GameSaveResource.get_save_files()

func _ready():
	for saveName in get_selectable_objects():
		var btn = Button.new()
		btn.text = saveName
		btn.connect("pressed",self,"emit_save_pressed",[saveName])
		
		btn.size_flags_vertical = btn.SIZE_EXPAND | btn.SIZE_FILL
		btnSaveContainer.add_child(btn)
		
func emit_save_pressed(saveName)->void:
	emit_signal("save_pressed",saveName)
