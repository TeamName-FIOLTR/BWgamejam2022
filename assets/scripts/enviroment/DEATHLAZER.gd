extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(bool) var lazer_on = true
export(bool) var object_enabled : bool = true setget set_object_enabled
export(bool) var kills_player = true
export(bool) var invert_bits : bool = true
export(int, LAYERS_2D_PHYSICS) var collision_layers
var killed_player = true
var previous_thing

func set_object_enabled(n_state):
	object_enabled = n_state
	if not is_inside_tree(): yield(self, "ready")
	material.set_shader_param("swapped", !object_enabled)
	$Position2D/Line2D.use_parent_material = !object_enabled
#	$RayCast2D.enabled = lazer_on
	kills_player = object_enabled

# Called when the node enters the scene tree for the first time.
func _ready():
#	set_lazer_state(lazer_on)
	$RayCast2D.enabled = lazer_on
	$Position2D.visible = lazer_on
	if invert_bits:
		collision_layers = ~collision_layers
#	$RayCast2D.collision_mask = collision_layers
	$StaticBody2D.collision_layer = collision_layers
	
	add_to_group("Swap Recievers")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var thing = $RayCast2D.get_collider()
	if thing is Player and not thing == previous_thing and kills_player:
		get_tree().call_group("Player Death Recievers", "recieve_player_death")
		$"Kill Sound".global_position = thing.global_position
		$"Kill Sound".play()
	elif thing:
		var y_coord = $RayCast2D.get_collision_point()
		var obj_thing : Line2D = $Position2D/Line2D
		var local = obj_thing.global_transform.affine_inverse()*y_coord
#		obj_thing.scale.y = local.y
		if not thing is Player:
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
#	$RayCast2D.set_collision_mask(0)
#	$RayCast2D.set_collision_mask_bit(0, true)
#	$RayCast2D.set_collision_mask_bit(1, true)
#
#	$RayCast2D.set_collision_mask_bit(2+swap_idx, true)
	self.object_enabled = ($StaticBody2D.get_collision_layer_bit(2+swap_idx))

func _on_Lever_Flipped(flipped):
	set_lazer_state(!lazer_on)

func _on_Button_Pressed(pressed):
	set_lazer_state(!lazer_on)
