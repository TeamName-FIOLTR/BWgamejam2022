extends Control

class_name AudioSliderControl

export var display_text_path : NodePath
onready var display_text : Label = get_node(display_text_path)

export var volume_slider_path : NodePath
onready var vol_slider : HSlider = get_node(volume_slider_path) as HSlider

var ready : bool = false

var channel_id : int = 0 setget set_channel,get_channel
func set_channel(val : int)->void:
	channel_id = val
	if AudioServer.is_bus_mute(channel_id):
		vol_slider.value = 0
	else:
		vol_slider.value = db2linear(AudioServer.get_bus_volume_db(channel_id))*50
	update_display_text()
func get_channel()->int:
	return channel_id

#sets the slider to monitor the given sound chanel
func set_channel_string(bus : String)->void:
	channel_id = AudioServer.get_bus_index(bus)
	update_display_text()


func update_display_text()->void:
	display_text.text = AudioServer.get_bus_name(channel_id) + " : "
	if AudioServer.is_bus_mute(channel_id):
		display_text.text += "Mute"
	else:
		display_text.text += ("%.0f" % (100*db2linear(AudioServer.get_bus_volume_db(channel_id))) ) + "%"

func log_base_2(x)->float:
	return log(x)/0.69314718056 #divide by ln(2) for the base change equation
	
func _on_HSlider_value_changed(value):
	if ready:
		value = value*2.0
		if value <= 2.0:
			#1 equates to mute, as we should never go over 0 dv
			Globals.config_data.audio_bus_db[AudioServer.get_bus_name(channel_id)] = 200
			Globals.save_config()
			
			AudioServer.set_bus_mute(channel_id,true)
		else:
			#1 equates to mute, as we should never go over 0 dv
			var volum = linear2db(value/100)
			
			#save configuration
			Globals.config_data.audio_bus_db[AudioServer.get_bus_name(channel_id)] = volum
			Globals.save_config()
			
			#update live
			AudioServer.set_bus_volume_db(channel_id,volum)
			AudioServer.set_bus_mute(channel_id,false)
		
		update_display_text()
#func _input(event):
#	if event.is_action_pressed("developer_debug"):
#		$Control/AudioStreamPlayer.play()


func _on_SoundSlider_ready():
	ready = true
