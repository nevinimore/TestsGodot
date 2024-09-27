shader_type canvas_item;

uniform float amp:hint_range(0.0, 1.0, 0.1) = 0.1;

void fragment() {
	vec2 upos = UV;
	float x = floor(upos.x);
	COLOR = texture(TEXTURE, upos + amp*vec2(.0, x));
}
