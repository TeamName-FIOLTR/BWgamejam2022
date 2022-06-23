extends AnimatedSprite

#this script is inteanded for controling animation trees on the Animated Sprite
#of the player cat

#basically any code that relies ONLY on the state of the animation should 
#be placed in this sprite so it can be used elsewhere if need be


func _on_AnimatedSprite_animation_finished():
	match animation:
		"idle_long":
			stop()
			frame = 6
		"damage":
			.play("idle")


func go_to_animation(anim : String,backwords : bool)->void:
	speed_scale = 2
	if anim != animation: #do nothing if we get an echo
		match anim:
			"idle":
				$long_idle_timer.start()
				if animation != "idle_long":
					.play(anim,backwords)
			"damage":
				speed_scale = 2.5
				.play(anim,backwords)
			_:
				.play(anim,backwords)

func play(anim : String="idle", backwords : bool=false)->void:
	if anim == "damage":
		print("damage!")
	match animation:
		"damage":
			pass #we ONLY change out of damage after it finishes playing
		_:
			if anim == "damage":
				print("playing damage animation")
			go_to_animation(anim,backwords) #we change out of every other animation as we would expect
func _on_long_idle_timer_timeout():
	play("idle_long")

