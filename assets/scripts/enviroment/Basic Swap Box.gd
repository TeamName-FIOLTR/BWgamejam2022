extends StaticBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
#export(Array, int) var enabled_swap_layers
export(bool) var object_enabled = true setget set_object_enabled


func set_object_enabled(n_state):
	object_enabled = n_state
	if not is_inside_tree(): yield(self, "ready")
	$CoolCube.material.set_shader_param("swapped", object_enabled)

# Called when the node enters the scene tree for the first time.
func _ready():
	var collision_thingy = get_collision_layer()
#	$StaticBody2D.set_collision_layer_bit(7, true)
	set_collision_layer(~collision_thingy)
	pass # Replace with function body.


func recieve_swap(swap_idx):
	self.object_enabled = (!get_collision_layer_bit(2+swap_idx))

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
