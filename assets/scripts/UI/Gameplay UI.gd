extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func recieve_player_lives(lives):
	$"Lives Lable".text = "Lives: %s"%lives
	if lives < 0:
		$"Lives Lable".text = "DEAD"


func recieve_swap_color(color):
	modulate = color

func recieve_level_failed():
	$"Fade Animation".play("Fade Out")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Fade_Animation_animation_finished(anim_name):
	if anim_name == "Fade Out":
		$"Level Failed UI".visible = true
		pass
	pass # Replace with function body.
