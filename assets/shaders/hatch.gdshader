shader_type canvas_item;

uniform vec4 forground_in : hint_color = vec4(1.0,1.0,1.0,1.0);
uniform vec4 background_in : hint_color = vec4(0.0,0.0,0.0,1.0);

uniform vec4 forground_out : hint_color = vec4(1.0,1.0,1.0,1.0);
uniform vec4 background_out : hint_color = vec4(0.0,0.0,0.0,1.0);

uniform float line_count = 100;
uniform float line_width = 0.006;
uniform float hatch_angle = 3.05;
uniform float snap_threshhold_front = 0.165;
uniform float snap_threshhold_back = 0.165;
float distance_squared(vec4 a,vec4 b) {
	return (a.r - b.r)*(a.r-b.r) + (a.g-b.g)*(a.g-b.g) + (a.b-b.b)*(a.b-b.b);
}
vec2 rotate(float angle,vec2 input) {	
	return mat2(vec2(cos(hatch_angle),cos(hatch_angle+ 1.57079632679)),
						vec2(sin(hatch_angle ),sin(hatch_angle + 1.57079632679)))*input;
}
bool do_line(float x,float lineCount,float lineWidth) {
	return mod(x,1.0/lineCount) <= lineWidth;//(1.0/line_count)/1.1;
}
vec4 color_snap(vec4 incolor, vec4 snap1, vec4 snap2,vec4 snapout1,vec4 snapout2){
	if (distance_squared(incolor,snap1) < distance_squared(incolor,snap2)) {
		return snapout1;
	}
	return snapout2;
}
void fragment() {
	vec4 original_color = texture(TEXTURE,UV);
	COLOR = color_snap(COLOR,forground_in,background_in,
							forground_out,background_out);
	
	vec2 rotated_uv = rotate(hatch_angle,UV);
	float distance_to_front = distance_squared(original_color,forground_in);
	float distance_to_back = distance_squared(original_color,background_in);
	
	if (distance_to_front > snap_threshhold_front || distance_to_back > snap_threshhold_back) {
		if ((do_line(rotated_uv.x,distance_to_front*distance_to_front*line_count,line_width) || 
			do_line(rotated_uv.y,distance_to_front*distance_to_front*line_count,line_width))) {
				COLOR = background_out;}
		else{
			COLOR = forground_out;
		}
	}
	
	
	COLOR.a = original_color.a;
}