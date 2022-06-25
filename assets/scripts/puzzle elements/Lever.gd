extends Area2D


export(bool) var flipped = false
export(Array, NodePath) var connected_elements setget set_connected_elements
export(bool) var object_enabled : bool = true setget set_object_enabled
export(bool) var invert_bits : bool = true

#export(NodePath) var lever_neck 
func set_connected_elements(n_elements):
	connected_elements = n_elements
	if not is_inside_tree(): yield(self, "ready")
	for element in connected_elements:
		var node = get_node(element)
		self.connect("flipped",node,"_on_Lever_Flipped")
func set_object_enabled(n_state):
	object_enabled = n_state
	if not is_inside_tree(): yield(self, "ready")
	material.set_shader_param("swapped", object_enabled)
# Declare member variables here. Examples:
# var a = 2
# var b = "text"



# Called when the node enters the scene tree for the first time.
func _ready():
	if flipped:
		$"Lever Base/Lever".rotation_degrees = 45
	else:
		$"Lever Base/Lever".rotation_degrees = -45
	if invert_bits:
		var collision_thingy = get_collision_layer()
		set_collision_layer(~collision_thingy)
	add_to_group("Swap Recievers")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

signal flipped(state)

func flip():
	flipped = !flipped
	if flipped:
		$AnimationPlayer.play("Flip")
	else:
		$AnimationPlayer.play_backwards("Flip")
	emit_signal("flipped", flipped)
	$"Lever Flip Sound".play()

func _on_Lever_body_entered(body):
#	print("LEVER TRIGGEREEREREREREWDRFDERF")
#	print(body)
	if body is Player:
		print("yuppers player collided yeah")
		flip()
	pass # Replace with function body.



func recieve_swap(swap_idx):
	self.object_enabled = (!get_collision_layer_bit(2+swap_idx))
