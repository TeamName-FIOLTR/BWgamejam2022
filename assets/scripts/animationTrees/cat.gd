extends AnimatedSprite

#this script is inteanded for controling animation trees on the Animated Sprite
#of the player cat

#basically any code that relies ONLY on the state of the animation should 
#be placed in this sprite so it can be used elsewhere if need be


func _on_AnimatedSprite_animation_finished():
	match animation:
		"idle_long":
			stop()

func play(anim : String="idle", backwords : bool=false)->void:
	match anim:
		"idle":
			$long_idle_timer.start()
	.play(anim,backwords)

func _on_long_idle_timer_timeout():
	play("idle_long")
