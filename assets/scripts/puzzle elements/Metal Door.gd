tool
extends StaticBody2D

export(bool) var opened = false setget set_opened
export(float) var opened_amount = 0.0 setget set_opened_amount

func set_opened(n_opened):
	opened = n_opened
	if not is_inside_tree(): yield(self, "ready")
	if opened:
		$AnimationPlayer.play("Open")
	else:
		$AnimationPlayer.play_backwards("Open")
	$"Door Opening Sound".play()

func set_opened_amount(n_amount):
	opened_amount = n_amount
	if not is_inside_tree(): yield(self, "ready")
	$"Door Mesh".material.set_shader_param("Opened", opened_amount)
	$"Scale Helper".scale.x = 1-opened_amount
	$CollisionShape2D.global_transform = $"Scale Helper/lil ref".global_transform
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Lever_Flipped(flipped):
	self.opened = !opened

func _on_Button_Pressed(pressed):
	self.opened = !opened
