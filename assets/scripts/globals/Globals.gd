extends Node

#stores data for this save
var game_save_data : GameSaveResource
#this stores configuration data and is loaded at run time
var config_data : ConfigResource

func _ready():
	#re-load our config data
	config_data = ConfigResource.get_config()
