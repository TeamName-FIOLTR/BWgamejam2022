extends Control

export(NodePath) var retry_button_node
export(NodePath) var exit_button_node
onready var retry_button : Button = get_node(retry_button_node)
onready var exit_button : Button = get_node(exit_button_node)

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func recieve_level_failed():
	retry_button.grab_focus()

func _on_Retry_Button_pressed():
	get_tree().reload_current_scene()
	pass # Replace with function body.


func _on_Exit_Button_pressed():
	get_tree().quit()
	pass # Replace with function body.


func _on_Level_Failed_UI_visibility_changed():
	retry_button.grab_focus()
	pass # Replace with function body.
