extends Node
#this is a node that is desinged with a back feature in mind

class_name BackContainerNode

#scene caching for faster switch times
var cached_scenes : Dictionary = {}
var do_scene_cache : bool = false
#the name of the current scene for the back button to use
export var current_scene_name : String
var past_scenes = []
func get_scene_path(ui_scene_name : String)->String:
	return "res://scenes/UI/" + ui_scene_name + ".tscn"

func grab_scene(ui_scene_name : String)->PackedScene:
	var pack = (load(get_scene_path(ui_scene_name)) as PackedScene)
	if do_scene_cache:
		cached_scenes[ui_scene_name] = pack
	return pack
		
func change_scene(ui_scene_name : String,remember_back : bool = true)->void:
	if remember_back:
		past_scenes.append(current_scene_name)
	
	#clear the existing children
	for child in get_children():
		child.queue_free()

	#add the new scene in
	if do_scene_cache:
		if not ui_scene_name in cached_scenes:
			print(get_scene_path(ui_scene_name))
			cached_scenes[ui_scene_name] = (load(get_scene_path(ui_scene_name)) as PackedScene)
		print("adding child")
		add_child(cached_scenes[ui_scene_name].instance())
	else:
		print("adding child")
		add_child((load(get_scene_path(ui_scene_name)) as PackedScene).instance())
	
	#save the name of the current scene for the back button
	current_scene_name = ui_scene_name

func back()->void:
	if len(past_scenes) > 0:
		change_scene(past_scenes[len(past_scenes)-1],false)
		past_scenes.remove(len(past_scenes)-1)
