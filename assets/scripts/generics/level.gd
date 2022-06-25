extends Node2D
#this is a generic script that the game levels are inteanded to inherit from

class_name Level

func _ready():
	add_to_group("Level Status Recievers")
	Globals.game_save_data.last_level = name
	Globals.save_game()
	
func fade_death()->void:
	pass
#	$FadePlayer.play("fade")
func reload()->void:
	get_tree().reload_current_scene()

func load_last_save()->void:
	GameSaveResource.return_to_save(get_tree(),Globals.game_save_data)

func recieve_level_failed():
	pass
#	fade_death()
