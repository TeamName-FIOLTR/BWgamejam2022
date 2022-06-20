extends Node
#this is a node that is desinged with a back feature in mind

class_name BackContainerNode

#scene caching for faster switch times
var cached_scenes : Dictionary = {}
var do_scene_cache : bool = true

func get_scene_path(ui_scene_name : String)->String:
	return "res://scenes/UI/" + ui_scene_name + ".tscn"

func grab_scene(ui_scene_name : String)->PackedScene:
	var pack = (load(get_scene_path(ui_scene_name)) as PackedScene)
	if do_scene_cache:
		cached_scenes[ui_scene_name] = pack
	return pack

func change_scene(ui_scene_name : String)->void:
	#clear the existing children
	for child in get_children():
		child.queue_free()

	#add the new scene in
	if do_scene_cache:
		if not cached_scenes[ui_scene_name]:
			cached_scenes[ui_scene_name] = (load(get_scene_path(ui_scene_name)) as PackedScene)
		add_child(cached_scenes[ui_scene_name].instance())
	else:
		add_child((load(get_scene_path(ui_scene_name)) as PackedScene).instance())
