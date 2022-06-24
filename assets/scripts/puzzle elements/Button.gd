extends Area2D

export(bool) var pressed
export(bool) var togglable
var toggled : bool = false

export(Array, NodePath) var connected_elements setget set_connected_elements

func set_connected_elements(n_elements):
	connected_elements = n_elements
	if not is_inside_tree(): yield(self, "ready")
	for element in connected_elements:
		var node = get_node(element)
		self.connect("pressed",node,"_on_Button_Pressed")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

signal pressed(value)

func _on_Button_body_entered(body):
	if body is Player:
		if !pressed:
			pressed = true
			$"Button Animation".play("Pressed")
			emit_signal("pressed", pressed)
		if togglable:
			toggled = !toggled
	pass # Replace with function body.


func _on_Button_body_exited(body):
	if body is Player:
		if (pressed and not togglable) or (pressed and !toggled):
			pressed = false
			$"Button Animation".play("Released")
			emit_signal("pressed", pressed)

	pass # Replace with function body.
