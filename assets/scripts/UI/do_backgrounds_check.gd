extends CheckBox


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pressed = Globals.config_data.do_backgrounds


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_CheckBox_toggled(button_pressed):
	Globals.config_data.do_backgrounds = button_pressed
	Globals.save_config()
	#ensure a re-sync of the background
	Globals.sync_background()
