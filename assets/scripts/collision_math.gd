extends Node
#this class contains the enumerator variables for
#the different game layers 
class_name ColMath

#returns the set bit of the given layer number
static func get_color_layer_bit(layer_number : int)->int:
	return Layer.PLAYER << layer_number

#gets the layer number from the given bits
static func get_layer_number(bits : int)->int:
	var new_bits = bits >> Layer.PLAYER

	#hideous logarithm
	var count : int = 1
	while new_bits != 1:
		count += 1
		new_bits = new_bits >> 1
	
	return count

enum Layer {
	CONSTANT_COLLISION=1,
	PLAYER=2,
	COLLISION_SWAP_ONE=4,
	COLLISION_SWAP_TWO=8,
	COLLISION_SWAP_THREE=16
}
