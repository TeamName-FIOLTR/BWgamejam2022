extends Button
#simple button that exists the game

class_name ExitButton

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("pressed",self,"on_press")

func on_press():
	get_tree().quit()
