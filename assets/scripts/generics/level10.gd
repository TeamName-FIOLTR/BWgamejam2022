extends Level


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func recieve_player_death():
	modulate = Color.black
	get_tree().paused = true
	$Timer.start()
	yield(get_tree(),"idle_frame")
	get_tree().call_group("Swap Recievers", "recieve_swap_color", Color.black)
	pass


func _on_Timer_timeout():
	get_tree().paused = false
	get_tree().change_scene("res://scenes/UI/StartLevel.tscn")
	
	pass # Replace with function body.
