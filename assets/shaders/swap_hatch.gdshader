shader_type canvas_item;
uniform bool swapped = true;

uniform vec4 forground_in : hint_color = vec4(1.0,1.0,1.0,1.0);
uniform vec4 background_in : hint_color = vec4(0.0,0.0,0.0,1.0);

uniform vec4 forground_out : hint_color = vec4(1.0,1.0,1.0,1.0);
uniform vec4 background_out : hint_color = vec4(0.0,0.0,0.0,1.0);

uniform float line_count = 100;
uniform float line_width = 0.006;
uniform float hatch_angle = 3.05;
uniform float snap_threshhold_front = 0.165;
uniform float snap_threshhold_back = 0.165;


uniform float outline_width;
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
vec4 color_snap_alpha(vec4 incolor, vec4 snap1, vec4 snap2,vec4 snapout1,vec4 snapout2) {
	if (incolor.a > 0.5) {
		return vec4(0.0,0.0,0.0,0.0);
	}
	if (distance_squared(incolor,snap1) < distance_squared(incolor,snap2)) {
		return snapout1;
	}
	return snapout2;
}
vec4 color_snap(vec4 incolor, vec4 snap1, vec4 snap2,vec4 snapout1,vec4 snapout2){
	if (distance_squared(incolor,snap1) < distance_squared(incolor,snap2)) {
		return snapout1;
	}
	return snapout2;
}
void fragment() {
	vec4 original_color = texture(TEXTURE,UV);
	COLOR = color_snap_alpha(COLOR,forground_in,background_in,
					forground_out,background_out);
	if (!swapped) {
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
	else {
		vec2 uv_left = UV+vec2(1,0)*outline_width;
	    vec2 uv_right = UV+vec2(-1,0)*outline_width;
	    vec2 uv_up = UV+vec2(0,1)*outline_width;
	    vec2 uv_down = UV+vec2(0,-1)*outline_width;
	    
	    float alpha_left = texture(TEXTURE,uv_left).a;
	    float alpha_right = texture(TEXTURE,uv_right).a;
	    float alpha_up = texture(TEXTURE,uv_up).a;
	    float alpha_down = texture(TEXTURE,uv_down).a;
	    
	    vec4 main_image_colors = COLOR.rgba;
	    
	    COLOR.a = min(alpha_left+alpha_right+alpha_down+alpha_up,1.0);
	    COLOR.rgb = background_out.rgb;
		
		if (original_color.a > outline_width) {
			COLOR.a = 0.0;
		}
	}
}