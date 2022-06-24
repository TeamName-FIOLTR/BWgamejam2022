extends Area2D

class_name Pickup

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("Pickup")
	connect("body_entered",self,"on_body_entered")

#called whenever we are picked up
#inteanded to set any and all state in the pickup
func on_pickup(player)->void:
	$pickupSound.playing = true

func on_body_entered(body):
	if body is Player:
		body.pickup(self)
		on_pickup(body)
