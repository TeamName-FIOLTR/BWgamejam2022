extends Pickup

class_name Tuna
var original_collision_layer : int
var original_collision_mask : int
# Called when the node enters the scene tree for the first time.
func _ready():
	original_collision_mask = collision_mask
	original_collision_layer = collision_layer
	add_to_group("Tuna")

func set_spawn():
	collision_layer = 0
	collision_mask = 0
	$Particles2D.emitting = true
	$TunaText.visible = false
func unset_spawn():
	collision_layer = original_collision_layer
	collision_mask = original_collision_mask
	monitorable = true
	monitoring = true
	$TunaText.visible = true
	$Particles2D.emitting = false

func on_pickup(player)->void:
	set_spawn()
	.on_pickup(player)
	
