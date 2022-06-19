extends VScrollBar

#generic UI node that picks a save to load
class_name SavePicker

export var vbContainer : NodePath
onready var btnSaveContainer : VBoxContainer = get_node(vbContainer)

func _ready():
	for i in GameSaveResource.get_save_files():
		var btn = Button.new()
		btn.text = i
		
