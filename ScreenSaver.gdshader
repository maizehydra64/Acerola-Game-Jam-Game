shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	vec2 res = 1.0/SCREEN_PIXEL_SIZE;
	vec2 pos = FRAGCOORD.xy/res;
	COLOR.r = abs(sin(pos.x+TIME)*cos(10.0*PI*pos.y+TIME)+0.25)-0.25;
	COLOR.g = abs(sin(pos.x+TIME+PI/2.0)+0.25)*cos(10.0*PI*pos.y+TIME+PI/2.0)-0.25;
	COLOR.b = abs(sin(8.0*PI*pos.x+pos.y+TIME- 2.0*(PI)/3.0)*cos(pos.y+TIME));
	COLOR.a = 1.0;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
