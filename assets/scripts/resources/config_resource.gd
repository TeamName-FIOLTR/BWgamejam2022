extends Resource
#generic class that stores configuration data for the game in a
#convinent format

#this resource is loaded regaurdless of the save that
#you pick and is a global config

class_name ConfigResource

var resolution : Vector2 = Vector2(1024,600)
var do_bloom : bool = false
var do_vsync : bool = false
var target_fps : int = 60


#convinence function for getting the path of a save resource
static func get_config_path()->String:
	return "user://config.res"

#convinence function to load a save resource from a game name
static func get_config()->ConfigResource:
	return ResourceLoader.load(get_config_path()) as ConfigResource

#save a config resource
static func save_config(conf : ConfigResource)->void:
	ResourceLoader.save(get_config_path(),conf)

static func sync_settings(conf : ConfigResource)->void:
	
