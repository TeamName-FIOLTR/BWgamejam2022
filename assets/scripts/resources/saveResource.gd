extends Resource
#this represents all config data that a specifc game
#saves

class_name GameSaveResource

#the name of the last scene that we saved at
#equivilent to the name of the root node in that level
var last_scene : String
#the name of the save file that we are in
var game_name : String


#initilizes the directory structure if it is not already
static func initilize_save_dir()->void:
	var dir = Directory.new()
	dir.open("user://")
	if not dir.dir_exists("user://saves/"):
		dir.make_dir("saves")

#returns the file names of all existing saves
static func get_save_files()->Array:
	var ret_val = []
	var dir = Directory.new()
	dir.open("user://saves/")
	dir.list_dir_begin()
	var fname = dir.get_next()
	while fname != "":
		if dir.current_is_dir():
			pass
		else:
			ret_val.append(
				fname.substr(0,len(fname)-4) #cut off the file path at the end to get the 
											#node name
				)
		fname = dir.get_next()
	return ret_val

#convinence function to get the scene path
static func get_scene_path(scene_name : String)->String:
	return "res://scenes/levels/" + scene_name + ".tscn"

#convinence function for getting the path of a save resource
static func get_save_resource_path(game_name : String)->String:
	return "user://saves/" + game_name + ".res"

#convinence function to load a save resource from a game name
static func get_save(game_name : String)->GameSaveResource:
	return ResourceLoader.load(get_save_resource_path(game_name)) as GameSaveResource
static func save(game_name : String,gsr : GameSaveResource)->void:
	ResourceLoader.save(get_save_resource_path(game_name))
