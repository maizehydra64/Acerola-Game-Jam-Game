shader_type canvas_item;

uniform float stamina;
uniform vec4 bar_color : source_color;
uniform vec4 back_color : source_color;
uniform bool flip_dir = false;
uniform float bar_opacity : hint_range(0.0, 1.0) = 1.0;
uniform float back_opacity : hint_range(0.0, 1.0) = 0.25;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	vec2 barCoord = vec2(clamp(stamina - UV.x * 100.0*((2.0*(1.0-float(flip_dir)))-1.0)+(float(flip_dir)*-100.0), 0.0,1.0),UV.y);
	vec2 invCoord = (barCoord-1.0)*-1.0; 
	COLOR.r = barCoord.x*bar_color.r+back_color.r*invCoord.x;
	COLOR.g = barCoord.x*bar_color.g+back_color.g*invCoord.x;
	COLOR.b = barCoord.x*bar_color.b+back_color.b*invCoord.x;
	COLOR.a = barCoord.x*bar_opacity+back_opacity;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
