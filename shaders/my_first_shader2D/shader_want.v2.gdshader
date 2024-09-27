shader_type canvas_item;

const int fig_width = 128;
const int fig_heigh = 128;

void vertex() {
}

void fragment() {
	vec2 upos = UV;
	vec2 pos = upos*FRAGCOORD.rg;
	
	//vec2 a = VIEWPORT_SIZE;
	
	//float x = floor(pos.x/(2.*float(fig_width)));
	float x = floor(upos.x);
	COLOR = texture(TEXTURE, upos + 0.1*vec2(.0, x));
	//COLOR.r = pos.x/728.;
	//COLOR.g = pos.y/728.;
	//COLOR.b = 0.;
	//COLOR.r = SCREEN_UV.x;
	//COLOR.g = SCREEN_UV.y;
	//COLOR.b = 0.;
	//COLOR.r = POINT_COORD.x;
	//COLOR.g = POINT_COORD.y;
	//COLOR.b = 0.;
	//COLOR.r = FRAGCOORD.x/900.;
	//COLOR.g = FRAGCOORD.y/600.;
	//COLOR.b = 0.;
	//COLOR.r = UV.x;
	//COLOR.g = UV.y;
	//COLOR.b = 0.;
	
	
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
