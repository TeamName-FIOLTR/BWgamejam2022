shader_type canvas_item;
uniform bool swapped;
uniform vec4 forground_in : hint_color;
uniform vec4 background_in : hint_color;
uniform vec4 forground_out : hint_color;
uniform vec4 background_out : hint_color;


uniform float outline_width;
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
	
	
	
	if (swapped) {
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
	    COLOR.rgb = forground_out.rgb;
		
		if (original_color.a > outline_width) {
			COLOR.rgb = background_out.rgb;
		}
 }   
}