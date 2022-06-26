extends SavePicker

class_name LevelPicker


func get_selectable_objects():
	return Globals.game_save_data.visited_levels
