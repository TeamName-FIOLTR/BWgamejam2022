extends AudioStreamPlayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	seek(Globals.music_play_position)
#	self.get_playback_position()
	pass # Replace with function body.


func recieve_level_failed():
	stop()
	Globals.music_play_position = get_playback_position()


func ok_level_change(thing):
	Globals.music_play_position = get_playback_position()
	return true
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
