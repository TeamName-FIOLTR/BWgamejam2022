shader_type canvas_item;
uniform float dark_width;

void fragment() {
	COLOR = texture(TEXTURE,UV);
	if (abs(UV[1]) < cos(TIME)) {
		COLOR = vec4(0.0,0.0,0.0,1.0);
	}
}