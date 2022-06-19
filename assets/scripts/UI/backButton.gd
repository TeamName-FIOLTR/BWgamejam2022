extends Button
#button that swaps visibility back to the last scene
class_name BackButton

#memory slot for the last scene that we were in
var last_scene = []

func _ready():
	connect("pressed",self,"back")

func remember_menu(cntr : Control)->void:
	last_scene.append(cntr)

#set up visibility for the last scene
func back()->void:
	if len(last_scene) > 0:
		for mainMenu in get_tree().get_nodes_in_group("menu_root"):
			mainMenu.visible = false
		last_scene[len(last_scene)-1].visible = true
		last_scene.remove(len(last_scene)-1)
