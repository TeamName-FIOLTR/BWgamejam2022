extends Panel
#this is the class file for a custom dual botton class
#that has a right and left button

#its a simple class inteanded to be re-used in different locations

class_name DualButton

signal left_button_pressed
signal right_button_pressed

func _on_Button_pressed():
	emit_signal("left_button_pressed")
func _on_Button2_pressed():
	emit_signal("right_button_pressed")
