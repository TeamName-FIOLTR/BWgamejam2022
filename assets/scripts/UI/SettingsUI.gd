extends Control

class_name SettingsUI
var UiIndicator = preload("res://scenes/UI/ControlEntryUI.tscn")

export var vbox_path : NodePath
var vbox : VBoxContainer

export var popup_dialog_path : NodePath
onready var popup_dialog : ActionMapDialog = get_node(popup_dialog_path) as ActionMapDialog
func sync_buttons()->void:
	for child in vbox.get_children():
		child.queue_free()
	for act in InputMap.get_actions():
		var ui_indicator = UiIndicator.instance() as UIControlMapEntry
		vbox.add_child(ui_indicator)
		ui_indicator.connect("change_ui_wanted",self,"update_connection")
		ui_indicator.load_action(act)
# Called when the node enters the scene tree for the first time.
func _ready():
	vbox = get_node(vbox_path)
	sync_buttons()


func update_connection(act):
	print(act)
	popup_dialog.action = act
	popup_dialog.show()

func _on_KeyPressDialog_update_action(act):
	sync_buttons()
