extends BackContainerNode

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

func _on_savePicker_save_pressed(save):
	GameSaveResource.load_game(get_tree(),save)
