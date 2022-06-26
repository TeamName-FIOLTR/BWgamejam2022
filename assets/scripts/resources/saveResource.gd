extends Resource
#this represents all config data that a specifc game
#saves

class_name GameSaveResource


#TODO: last_level would be more efficiently stored as an integer
#but that requires re-writing the level script


#the name of the last scene that we saved at
#equivilent to the name of the root node in that level
export var last_level : String = "Level1"

#the name of the save file that we are in
export var game_name : String

#the farthest unlocked level that the player has accessed
#stored as an intager for convinence
export var visited_levels : Dictionary

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

static func get_level_name_from_int(number : int)->String:
	return "level" + str(number)

#convinence function to get the level path
static func get_scene_path(level_name : String)->String:
	return "res://scenes/levels/" + level_name + ".tscn"

#convinence function for getting the path of a save resource
static func get_save_resource_path(game_name : String)->String:
	return "user://saves/" + game_name + ".res"

#convinence function to load a save resource from a game name
static func get_save(game_name : String)->GameSaveResource:
	var ret_val =  ResourceLoader.load(get_save_resource_path(game_name)) as GameSaveResource
	#just incase data gets desynced
	ret_val.game_name = game_name
	return ret_val
	
static func save(gsr : GameSaveResource)->void:
	ResourceSaver.save(get_save_resource_path(gsr.game_name),gsr)

#returns the game to the given save state	
static func return_to_save(tree : SceneTree,gsr : GameSaveResource)->void:
	Globals.game_save_data = gsr
	tree.change_scene(get_scene_path(gsr.last_level))
	
#loads the game with the given name
static func load_game(tree : SceneTree,game_name : String)->void:
	tree.paused = false
	Globals.game_save_data = get_save(game_name)
	print("returning to save " + Globals.game_save_data.last_level)
	return_to_save(tree,Globals.game_save_data)
