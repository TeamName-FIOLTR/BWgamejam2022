extends Node
#this class contains the enumerator variables for
#the different game layers 
class_name ColMath

#returns the set bit of the given layer number
static func get_color_layer_bits(layer_number : int)->int:
	return Layer.COLLISION_LAYER_ONE << layer_number

#gets the layer number from the given bits
static func get_layer_number(bits : int)->int:
	var new_bits = bits >> Layer.PLAYER

	#hideous logarithm
	var count : int = 1
	while new_bits != 1:
		count += 1
		new_bits = new_bits >> 1
	
	return count - 1

static func get_layer_color(layer_number : int , Layer_Count : int = DEFAULT_LAYER_COUNT,offset : float = 0.5)->Color:
	return Color.from_hsv(float(layer_number) / float(Layer_Count) + offset,1.0,1.0)

const DEFAULT_LAYER_COUNT = 3
enum Layer {
	CONSTANT_COLLISION=1,
	PLAYER=2,
	COLLISION_LAYER_ONE=4,
	COLLISION_LAYER_TWO=8,
	COLLISION_LAYER_THREE=16
}
