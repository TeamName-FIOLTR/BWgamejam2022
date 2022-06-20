extends UINameSelector

class_name UINewGame


func _on_GameSelector_text_entered(text):
	var new_save = GameSaveResource.new()
	new_save.game_name = text
	
	GameSaveResource.save(new_save)
	GameSaveResource.return_to_save(get_tree(),new_save)
