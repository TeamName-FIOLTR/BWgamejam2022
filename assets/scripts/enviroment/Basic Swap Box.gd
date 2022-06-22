extends StaticBody2D

class_name CollisionSwapper

export(bool) var object_enabled : bool = true setget set_object_enabled
export(bool) var invert_bits : bool = true

func set_object_enabled(n_state):
	object_enabled = n_state
	if not is_inside_tree(): yield(self, "ready")
	$Sprite.material.set_shader_param("swapped", object_enabled)

# Called when the node enters the scene tree for the first time.
func _ready():
	if invert_bits:
		var collision_thingy = get_collision_layer()
		set_collision_layer(~collision_thingy)
	add_to_group("Swap Recievers")

func recieve_swap(swap_idx):
	self.object_enabled = (!get_collision_layer_bit(2+swap_idx))
