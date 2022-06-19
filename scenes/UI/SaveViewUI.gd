extends ScrollContainer

#generic UI node that picks a save to load
class_name SavePicker

export var vbContainer : NodePath
onready var btnSaveContainer : VBoxContainer = get_node(vbContainer)

signal save_pressed

func _ready():
	for saveName in GameSaveResource.get_save_files():
		var btn = Button.new()
		btn.text = saveName
		btn.connect("pressed",self,"emit_save_pressed",[saveName])
		btnSaveContainer.add_child(btn)
		
func emit_save_pressed(saveName)->void:
	emit_signal("save_pressed",saveName)
