extends SavePicker


func _on_save_picker_save_pressed(save):
	GameSaveResource.load_game(get_tree(),save)
