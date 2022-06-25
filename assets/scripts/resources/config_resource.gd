extends Resource
#generic class that stores configuration data for the game in a
#convinent format

#this resource is loaded regaurdless of the save that
#you pick and is a global config

class_name ConfigResource

export var resolution : Vector2 = Vector2(1024,600)
export var do_bloom : bool = false
export var do_vsync : bool = false
export var target_fps : int = 60
export var audio_bus_db : Dictionary = {}
export var input_map : Dictionary = {}


static func encode_input_map()->Dictionary:
	var ret_val : Dictionary
	
	for action in InputMap.get_actions():
		ret_val[action] = InputMap.get_action_list(action)[0]
		
	return ret_val
#syncs us with a given input map
static func decode_input_map(inp_map_dict : Dictionary)->void:
	for act in inp_map_dict:
		InputMap.action_erase_events(act)
		InputMap.action_add_event(act,inp_map_dict[act])
#convinence function for getting the path of a save resource
static func get_config_path()->String:
	return "user://config.tres"


#convinence function to load a save resource from a game name
static func get_config()->ConfigResource:
	return ResourceLoader.load(get_config_path()) as ConfigResource

#save a config resource
static func save_config(conf : ConfigResource)->void:
	print("config resource saving! " + str(conf.resolution))
	ResourceSaver.save(get_config_path(),conf)

static func sync_settings(tree : SceneTree,conf : ConfigResource)->void:
	(tree.get_root() as Viewport).size = conf.resolution
	Engine.target_fps = conf.target_fps
	OS.set_use_vsync(conf.do_vsync)
	
	
	for channel in conf.audio_bus_db:
		var idx = AudioServer.get_bus_index(channel)
		
		if conf.audio_bus_db[channel] >= 200:
			AudioServer.set_bus_mute(idx,true)
		else:
			AudioServer.set_bus_mute(idx,false)
			AudioServer.set_bus_volume_db(idx,conf.audio_bus_db[channel])
	
	decode_input_map(conf.input_map)

#convinence function that syncs to the config data and returns a reference to it
static func get_and_sync_conf(tree : SceneTree)->ConfigResource:
	var ret_val = get_config()
	sync_settings(tree,ret_val)
	return ret_val
