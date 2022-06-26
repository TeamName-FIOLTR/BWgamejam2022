extends AreaColSwapper
#this script ends the level that you are currently on
#and loads the next level

export var next_level : String



func _on_LevelChangeArea_body_entered(body):
	if body is Player:
		get_tree().change_scene(GameSaveResource.get_scene_path(next_level))
