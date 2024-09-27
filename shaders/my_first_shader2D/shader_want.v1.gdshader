shader_type canvas_item;

void vertex() {
	//VERTEX += vec2(0, VERTEX.x);
	
	if(VERTEX.x<200.0){
		VERTEX += vec2(0, floor(VERTEX.x/10.0)*10.0);
	}
	if(VERTEX.t<.5){
		VERTEX += vec2(0, floor(VERTEX.x/10.0)*10.0);
	}
}

void fragment() {
	// Called for every pixel the material is visible on.
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
