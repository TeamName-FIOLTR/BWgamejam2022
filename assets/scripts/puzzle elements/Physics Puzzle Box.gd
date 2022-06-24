extends RigidBody2D

export(bool) var object_enabled : bool = true setget set_object_enabled
export(bool) var move_when_enabled = true
export(bool) var move_when_disabled = false
export(bool) var invert_bits : bool = true
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func set_object_enabled(n_enabled):
	object_enabled = n_enabled
	if not is_inside_tree(): yield(self, "ready")
	if (object_enabled and move_when_enabled) or (!object_enabled and move_when_disabled):
		mode = MODE_RIGID
	else:
		mode = MODE_STATIC
	material.set_shader_param("swapped", object_enabled)

# Called when the node enters the scene tree for the first time.
func _ready():
	if invert_bits:
		var collision_thingy = get_collision_layer()
		set_collision_layer(~collision_thingy)
	add_to_group("Swap Recievers")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func recieve_swap(swap_idx):
	self.object_enabled = (!get_collision_layer_bit(2+swap_idx))
