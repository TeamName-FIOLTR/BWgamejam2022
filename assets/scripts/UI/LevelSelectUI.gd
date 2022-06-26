extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_level_picker_save_pressed(lvl):
	var tree = get_tree()
	tree.paused = false
	tree.change_scene(GameSaveResource.get_scene_path(lvl))
