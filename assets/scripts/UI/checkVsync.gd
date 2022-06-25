extends CheckBox


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	toggle_mode = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_CheckBox_toggled(button_pressed):
	OS.vsync_enabled = button_pressed
	Globals.config_data.do_vsync = button_pressed
	Globals.save_config()
