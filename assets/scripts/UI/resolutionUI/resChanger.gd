extends Control
#this script is used in the ResolutionChanger to change the resolution of the game
export var width_path : NodePath
onready var width : LineEdit = get_node(width_path) as NumberBox

export var height_path : NodePath
onready var height : LineEdit = get_node(height_path) as NumberBox

var standard_res_idx : int = 0
var standard_resolutions = [
	Vector2(960,540),
	Vector2(1280,720),
	Vector2(2048,1080),
	Vector2(2560,1440),
	Vector2(3840,2160),
	Vector2(4096,2160),
	Vector2(5120,2880),
	Vector2(7680,4320)
]

func change_game_aspect(width : int, height : int,scale_factor : int = 0)->void:
	Globals.config_data.resolution = Vector2(width, height)
	
	get_tree().get_root().size = Vector2(width, height)
	
	Globals.save_config()
	
func update_resolution()->void:
	change_game_aspect(width.numeric_value,height.numeric_value)

func _ready():
	var size = get_tree().get_root().get_size()
	width.set_number_value(size.x)
	height.set_number_value(size.y)

func _on_width_number_changed(width):
	update_resolution()


func _on_height_number_changed(height):
	update_resolution()

func _on_Button_pressed():
	standard_res_idx = (standard_res_idx + 1) % len(standard_resolutions)
	width.set_number_value(standard_resolutions[standard_res_idx].x)
	height.set_number_value(standard_resolutions[standard_res_idx].y)
