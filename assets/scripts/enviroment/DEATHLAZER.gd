extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(bool) var lazer_on = true
var killed_player = true
var previous_thing

# Called when the node enters the scene tree for the first time.
func _ready():
#	set_lazer_state(lazer_on)
	$RayCast2D.enabled = lazer_on
	$Position2D.visible = lazer_on
	add_to_group("Swap Recievers")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var thing = $RayCast2D.get_collider()
	if thing is Player and not thing == previous_thing:
		get_tree().call_group("Player Death Recievers", "recieve_player_death")
		$"Kill Sound".global_position = thing.global_position
		$"Kill Sound".play()
	elif thing:
		var y_coord = $RayCast2D.get_collision_point()
		var obj_thing : Line2D = $Position2D/Line2D
		var local = obj_thing.global_transform.affine_inverse()*y_coord
#		obj_thing.scale.y = local.y
		obj_thing.points[1].y = local.y
	else:
		$Position2D/Line2D.points[1].y = $RayCast2D.cast_to.y
	previous_thing = thing
#	pass
func enable_lazer():
	$RayCast2D.visible = true
	$Position2D.visible = true

func set_lazer_state(on):
	lazer_on = on
#	$RayCast2D.visible = on
	$RayCast2D.enabled = on
	$Position2D.visible = on
	if !on:
		$"Lazer Enable Sound".play()
	else:
		$"Lazer Disable Sound".play()

func recieve_swap(swap_idx):
	print("recived swap!")
	$RayCast2D.collision_mask = ColMath.Layer.CONSTANT_COLLISION | ColMath.Layer.PLAYER | ColMath.get_color_layer_bits(swap_idx)


func _on_Lever_Flipped(flipped):
	set_lazer_state(!lazer_on)

func _on_Button_Pressed(pressed):
	set_lazer_state(!lazer_on)
