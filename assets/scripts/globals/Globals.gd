extends Node

#stores data for this save
var game_save_data : GameSaveResource
#this stores configuration data and is loaded at run time
var config_data : ConfigResource

#saves the current configuration file to the disk
func save_config()->void:
	ConfigResource.save_config(config_data)
func save_game()->void:
	GameSaveResource.save(game_save_data)

#syncs the background with the do_background variable
func sync_background()->void:
	#hide the backgrounds if we are supposed to hide them
	for node in get_tree().get_nodes_in_group("background"):
		node.visible = config_data.do_backgrounds

#sets up a configuration file if we need to set one up
func initilize_configuration()->void:
	var file_checker = File.new()
	if not file_checker.file_exists(ConfigResource.get_config_path()):
		print("making new configuration file!")
		var new_file = ConfigResource.new()
		ConfigResource.save_config(new_file)

func _ready():
	#initlize our configuration if we don't have one
	initilize_configuration()
	Globals.config_data = ConfigResource.get_and_sync_conf(get_tree())
