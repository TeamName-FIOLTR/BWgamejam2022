shader_type canvas_item;

uniform vec4 forground_in : hint_color;
uniform vec4 background_in : hint_color;
uniform vec4 forground_out : hint_color;
uniform vec4 background_out : hint_color;
float distance_squared(vec4 a,vec4 b) {
	return (a.r - b.r)*(a.r-b.r) + (a.g-b.g)*(a.g-b.g) + (a.b-b.b)*(a.b-b.b);
}
void fragment() {
	vec4 original_color = texture(TEXTURE,UV);
	COLOR = original_color;
	if (distance_squared(COLOR,forground_in) < distance_squared(COLOR,background_in)) {
		COLOR = forground_out;
	}
	else {
		COLOR = background_out;
	}
	COLOR.a *= original_color.a;
}