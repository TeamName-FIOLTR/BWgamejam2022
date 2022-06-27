extends AreaColSwapper
#this script ends the level that you are currently on
#and loads the next level

export var next_level : String



func _on_LevelChangeArea_body_entered(body):
	if body is Player:
		var lvl_changers = get_tree().get_nodes_in_group("Level Change Confirm")
		var enabled : bool = true
		
		for node in lvl_changers:
			if node.has_method("ok_level_change"):
				enabled = enabled && node.ok_level_change(self)
				if not enabled:
					break
		
		if enabled:
			get_tree().change_scene(GameSaveResource.get_scene_path(next_level))
		
		enabled = true
