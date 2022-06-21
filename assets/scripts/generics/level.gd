extends Node2D
#this is a generic script that the game levels are inteanded to inherit from

class_name Level

func _ready():
	$FadePlayer.connect("animation_finished",self,"anim_finished")
func anim_finished(anim):
	print("finished animation " + anim)
	match anim:
		"fade":
			reload()
			
func fade_death()->void:
	$FadePlayer.play("fade")
func reload()->void:
	get_tree().reload_current_scene()
func load_last_save()->void:
	print("loading save")
	GameSaveResource.return_to_save(get_tree(),Globals.game_save_data)
