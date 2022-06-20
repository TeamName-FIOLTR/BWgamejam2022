extends Control

class_name UINameSelector

export var button_path : NodePath
onready var button : Button = get_node(button_path) as Button

export var text_path : NodePath
onready var text : LineEdit = get_node(text_path) as LineEdit

signal text_entered

# Called when the node enters the scene tree for the first time.
func _ready():
	text.connect("text_entered",self,"on_text_entered")
	button.connect("pressed",self,"on_text_entered")

func on_text_entered():
	emit_signal("text_entered",text.text)
