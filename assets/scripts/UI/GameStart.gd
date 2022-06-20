extends Control

class_name MainUI

func _ready():
	#initilize the game save dir if it is not already
	GameSaveResource.initilize_save_dir()

func _on_exit_pressed():
	#leav the game
	get_tree().quit()

#create a new game with the given name, overides existing games
func _on_NewGameNameSelect_text_entered(text):
	var gsr = GameSaveResource.new()
	gsr.game_name = text
	
	GameSaveResource.save(gsr)
	
	GameSaveResource.return_to_save(get_tree(),gsr)

#memory slot for the last scene that we were in
var last_scene = []
func remember_menu(cntr : Control)->void:
	last_scene.append(cntr)

#set up visibility for the last scene
func back()->void:
	if len(last_scene) > 0:
		for mainMenu in get_tree().get_nodes_in_group("menu_root"):
			mainMenu.visible = false
		last_scene[len(last_scene)-1].visible = true
		last_scene.remove(len(last_scene)-1)

func _on_savePicker_save_pressed(save):
	GameSaveResource.load_game(get_tree(),save)
