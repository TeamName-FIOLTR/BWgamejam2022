extends NumberBox


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	set_number_value(Globals.config_data.target_fps)


func _on_CheckBox_number_changed(value):
	Engine.target_fps = value
	Globals.config_data.target_fps = value
	Globals.save_config()
