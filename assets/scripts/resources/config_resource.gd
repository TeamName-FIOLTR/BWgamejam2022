extends Resource
#generic class that stores configuration data for the game in a
#convinent format

#this resource is loaded regaurdless of the save that
#you pick and is a global config

class_name ConfigResource

#Example variables that could go inside of global config
#var resolution
#var color_blindness ect.


#convinence functions for reading and writing to disc

#convinence function for getting the path of a save resource
static func get_config_path()->String:
	return "user://config.res"

#convinence function to load a save resource from a game name
static func get_config()->ConfigResource:
	return ResourceLoader.load(get_config_path()) as ConfigResource

#save a config resource
static func save_config(conf : ConfigResource)->void:
	ResourceLoader.save(get_config_path(),conf)
