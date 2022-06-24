extends Node2D
#this is a generic script that the game levels are inteanded to inherit from

class_name Level

func _ready():
	add_to_group("Level Status Recievers")
	$FadePlayer.connect("animation_finished",self,"anim_finished")
func fade_death()->void:
	$FadePlayer.play("fade")
func reload()->void:
	get_tree().reload_current_scene()

func load_last_save()->void:
	GameSaveResource.return_to_save(get_tree(),Globals.game_save_data)

func recieve_level_failed():
	fade_death()
