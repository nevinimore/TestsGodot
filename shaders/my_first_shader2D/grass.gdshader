shader_type canvas_item;

const float speed = 2.;
const float amp = 100.;

void vertex() {
	float t = float(TIME);
	float variation = sin(t*speed);
	variation *= amp;
	
	if(VERTEX.y<0.){
		VERTEX += vec2(variation, .0);
	}
	
}
