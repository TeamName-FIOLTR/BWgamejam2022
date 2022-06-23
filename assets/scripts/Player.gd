extends Entity
class_name Player
export(float) var speed = 1.0
export(float) var jump_gravity = 0.2
export(float) var drop_gravity = 1.0
export(float) var jump_speed = 100
export(float) var jump_time_max = 0.3 setget set_jump_time_max
export(float) var input_velocity_scale = 500
export(float) var jump_cache_time = 50
export(float) var coyote_time = 100
export(int) var lives = 9
export(NodePath) var jump_timer_node
export(NodePath) var player_audio_node
var input_velocity = Vector2(0,0)
var jumping = false
var dropping = false
var jump_cached_time = 50
var jump_press_time = 0
var jump_cached = false
var last_collision_time = 0
var start_position : Vector2 = Vector2(0,0)
var dead = false
onready var jump_timer : Timer = get_node(jump_timer_node)
onready var player_audio_player = get_node(player_audio_node)

#the number of layers that we swap between
export var layer_count : int = 3
#export(int) var current_layer

#returns the level node that we are in
func get_level_node()->Level:
	return get_parent().get_parent() as Level

func set_jump_time_max(n_jump_time):
	jump_time_max = n_jump_time
	if not is_inside_tree(): yield(self, "ready")
	jump_timer.wait_time = jump_time_max

# Called when the node enters the scene tree for the first time.
func _ready():
	print(ColMath.get_layer_number(ColMath.Layer.COLLISION_LAYER_TWO))
	print(ColMath.get_color_layer_bits(ColMath.get_layer_number(ColMath.Layer.COLLISION_LAYER_TWO)))
	print(ColMath.Layer.COLLISION_LAYER_TWO)
	
	collision_mask |= ColMath.Layer.COLLISION_LAYER_TWO
	jump_timer.wait_time = jump_time_max
	start_position = position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if jumping:
		velocity += gravity*delta*jump_gravity
	else:
		velocity += gravity*delta*drop_gravity
	velocity.x = input_velocity.x
	var collision = move_and_collide(velocity*delta*speed)
	if collision:
		var hit_volume = linear2db(velocity.length()/3000)
		velocity = move_and_slide(velocity*speed,collision.normal)
		if dropping:
			var pitch = lerp(0.9,1.1,randf())
			play_landing_sound(pitch,hit_volume)
			
		jumping = false
		dropping = false
		if jump_cached:
			var collision_time = OS.get_ticks_usec()
			if collision_time-jump_cached_time <= 1000*jump_cache_time:
				jump()
			jump_cached = false
		last_collision_time = OS.get_ticks_usec()
	elif not jumping:
		dropping = true
	update_animation()

func jump():
	velocity.y = -jump_speed
	jumping = true
	$"Jump Timer".start()

func play_landing_sound(pitch, volume):
#	var pitch = lerp(0.9,1.1,randf())
	if not dead:
		player_audio_player.pitch_scale = pitch
		player_audio_player.volume_db = volume
		player_audio_player.play()

#swaps to the given color layer
func swap_to(color_layer : int)->void:
	collision_mask = ColMath.get_color_layer_bits(color_layer) | ColMath.Layer.CONSTANT_COLLISION
	get_parent().modulate = ColMath.get_layer_color(color_layer,layer_count)
	get_tree().call_group("Swap Recievers", "recieve_swap", color_layer)
	$AnimatedSprite.play("damage")
#swaps to the next color layer
func swap_next()->void:
	print("on layer " + str(ColMath.get_layer_number(collision_mask)))
	var swap_layer = (ColMath.get_layer_number(collision_mask) + 1) % layer_count
	swap_to(swap_layer)

#called by a pickup when we enter it
#sets any and all variables related to the player
#and the pickup
func pickup(pick : Area2D)->void:
	if pick.is_in_group("Tuna"):
		start_position = pick.position

func _input(event):
	if not dead:
		if event is InputEventKey or InputEventJoypadMotion:
			input_velocity = input_velocity_scale*Input.get_vector("move_left", "move_right", "move_up", "move_down")
		if event.is_action_pressed("jump"):
			var coyote_jump = (OS.get_ticks_usec()-last_collision_time<=1000.0*coyote_time)
			if (not (jumping or dropping)) or (dropping and coyote_jump):
				jump()
			elif dropping and !jump_cached:
				jump_cached = true
				jump_cached_time = OS.get_ticks_usec()
		if event.is_action_released("jump") and jumping:
			dropping = true
			jumping = false
		if event.is_action_pressed("developer_debug"):
			swap_next()
		
		update_animation()
#updates the animation of the cat
func update_animation()->void:
	if input_velocity.x > 0:
		$AnimatedSprite.flip_h = true
	elif input_velocity.x < 0:
		$AnimatedSprite.flip_h = false
	
	if abs(velocity.y) > 0:
		$AnimatedSprite.playing = false
		$AnimatedSprite.animation = "jump"
		if velocity.y > 0.5:
			$AnimatedSprite.frame = 2
		elif velocity.y > 0:
			$AnimatedSprite.frame = 1
		else:
			$AnimatedSprite.frame = 0
	elif not (jumping or dropping):
		$AnimatedSprite.playing = true
		if abs(input_velocity.x) > 0:
			$AnimatedSprite.play("run")
		else:
			$AnimatedSprite.play("idle")

func recieve_player_death():
	if lives <= 0:
		$Camera2D/AnimationPlayer.play("screen_shake")
		get_level_node().fade_death()
		get_tree().call_group("Level Status Recievers", "recieve_level_failed")
		$level_fail_sound.play()
		$deathsound.play()
		speed = 0.05 #slow down for death
		dead = true
	else:
	#	dead = true
		lives -= 1
		var global_pos = global_position
		position = start_position
	#	velocity = Vector2.ZERO
		swap_next()
		
		$deathsound.global_position = global_pos
		$deathsound.play()
		
		$"respawn sound".play()
		$"Spawn Animation/AnimationPlayer".play("Spawn")
		
	#	dead = false
		pass

func _on_Jump_Timer_timeout():
	dropping = true
	jumping = false
	update_animation()
