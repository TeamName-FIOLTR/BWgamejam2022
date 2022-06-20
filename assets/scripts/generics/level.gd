extends Node2D
#this is a generic script that the game levels are inteanded to inherit from

class_name Level


func _ready():
	print("running game save " + Globals.game_save_data.game_name)
