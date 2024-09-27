shader_type canvas_item;

uniform float blue_value = .8;

void vertex() {
	VERTEX += vec2(10, 0);
}

void fragment() {
	// COLOR = vec4(.4, .6, 1.0, 1.0);
	// COLOR = vec4(.4, UV , 1.0);
	//COLOR = texture(TEXTURE, UV);
	//COLOR.b = blue_value;
	//COLOR = texture(TEXTURE, UV+vec2(0, -.1));
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
