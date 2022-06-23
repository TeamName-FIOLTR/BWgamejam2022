extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var killed_player = true
var previous_thing

# Called when the node enters the scene tree for the first time.
func _ready():
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

func recieve_swap(swap_idx):
	$RayCast2D.set_collision_mask(0)
	$RayCast2D.set_collision_mask_bit(0, true)
	$RayCast2D.set_collision_mask_bit(1, true)
	$RayCast2D.set_collision_mask_bit(2+swap_idx, true)
