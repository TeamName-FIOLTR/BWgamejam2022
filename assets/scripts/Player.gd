extends Entity

export(float) var jump_gravity = 0.2
export(float) var drop_gravity = 1.0
export(float) var jump_speed = 100
export(float) var jump_time_max = 0.3 setget set_jump_time_max
export(Vector2) var input_velocity = Vector2(0,0)
export(float) var input_velocity_scale = 500
export(bool) var jumping = false
export(bool) var dropping = false
export(float) var jump_cache_time = 50
export(float) var jump_cached_time = 50
export(int) var jump_press_time = 0
export(bool) var jump_cached = false
export(NodePath) var jump_timer_node
onready var jump_timer : Timer = get_node(jump_timer_node)
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func set_jump_time_max(n_jump_time):
	jump_time_max = n_jump_time
	if not is_inside_tree(): yield(self, "ready")
	jump_timer.wait_time = jump_time_max

# Called when the node enters the scene tree for the first time.
func _ready():
	jump_timer.wait_time = jump_time_max
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if jumping:
		velocity += gravity*delta*jump_gravity
	else:
		velocity += gravity*delta*drop_gravity
#	velocity += input_velocity
	velocity.x = input_velocity.x
	var collision = move_and_collide(velocity*delta)
	if collision:
		var hit_volume = linear2db(velocity.length()/3000)
#		velocity = velocity-velocity.project(collision.normal)
		velocity = velocity.slide(collision.normal)
		if dropping:
#			print("gonna start playing")
			var pitch = lerp(0.9,1.1,randf())
			play_landing_sound(pitch,hit_volume)
			
		jumping = false
		dropping = false
		if jump_cached:
			var collision_time = OS.get_ticks_usec()
			if collision_time-jump_cached_time <= 1000*jump_cache_time:
				jump()
			jump_cached = false
		
#	if collision:
#		print("COLLLLISIONSNSNSN ", collision)
#	pass
func jump():
	velocity.y = -jump_speed
	jumping = true
	$"Jump Timer".start()

func play_landing_sound(pitch, volume):
#	var pitch = lerp(0.9,1.1,randf())
	$AudioStreamPlayer2D.pitch_scale = pitch
	$AudioStreamPlayer2D.volume_db = volume
	$AudioStreamPlayer2D.play()
func _input(event):
#	print("wowoaahaha ", event.as_text())
#	print(event.)
#	if event.is_action_pressed("jump"):
#		print("\nJUMP")
#	if event is InputEventAction:
#		print("yupppoers inpute vnet actionsohnisolifkhsdajlksadffdajklsv;")
	if event is InputEventKey or InputEventJoypadMotion:
		input_velocity = input_velocity_scale*Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if event.is_action_pressed("jump"):
#		print("\nJUMP")
#		print(velocity)
#		velocity.y = -jump_speed
		if not (jumping or dropping):
			jump()
		elif dropping and !jump_cached:
			jump_cached = true
			jump_cached_time = OS.get_ticks_usec()
			
#		print(velocity)
	if event.is_action_released("jump") and jumping:
		dropping = true
		jumping = false


func _on_Jump_Timer_timeout():
	dropping = true
	jumping = false
	pass # Replace with function body.
