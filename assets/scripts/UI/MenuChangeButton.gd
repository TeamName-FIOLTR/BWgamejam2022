extends Button
#this is a button that changes the given UI to the given menu from the menu that the button is in

class_name MenuChangeButton

#the root of the menu that we are working with
export var root_path : NodePath
onready var root_node : Control = get_node(root_path)

#the menu that we are swaping to
export var to_scene : String

func _ready():
	connect("pressed",self,"on_pressed")

func change_menu()->void:
	(root_node.get_parent() as BackContainerNode).change_scene(to_scene)

func on_pressed():
	change_menu()
