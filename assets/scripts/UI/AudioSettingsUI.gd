extends Control

export var vbox_path : NodePath
onready var vbox = get_node(vbox_path) as VBoxContainer

var audioSlider = preload("res://scenes/UI/SoundSlider.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	for channel in range(0,AudioServer.bus_count):
		print(channel)
		var audio_instance = audioSlider.instance() as AudioSliderControl
		vbox.add_child(audio_instance)
		audio_instance.channel_id = channel



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
