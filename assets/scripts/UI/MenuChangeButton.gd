extends Button
#this is a button that changes the given UI to the given menu from the menu that the button is in

class_name MenuChangeButton

#the root of the menu that we are working with
export var BackButtonPath : NodePath
onready var back_button : BackButton = get_node(BackButtonPath)

#the menu that we are swaping from
export var FromMenuPath : NodePath
onready var from_menu : Control = get_node(FromMenuPath)

#the menu that we swap to
export var ToMenuPath : NodePath
onready var to_menu = get_node(ToMenuPath)

func _ready():
	connect("pressed",self,"on_pressed")

func change_menu()->void:
	back_button.remember_menu(from_menu)
	from_menu.visible = false
	to_menu.visible = true

func on_pressed():
	change_menu()
