shader_type canvas_item;


//const vec3 def_color = vec3(241.0, 231.0, 126.0) / 256.0;
uniform vec3 replacement_color:source_color = vec3(.9, .8, .5);

void fragment() {
	vec3 img = COLOR.rgb;
	vec3 not_green_part = img * vec3(1, 0, 1);
	float not_green_qtd = length(not_green_part);
	float not_green_qtd_bool = step(.01, not_green_qtd);
	vec3 not_green_bool = vec3(not_green_qtd_bool);
	
	vec3 without_green = img*not_green_bool;
	
	vec3 green_bool = 1. - not_green_bool;
	vec3 the_green_part = green_bool * img.g;
	
	vec3 green_modified = replacement_color * the_green_part;
	
	vec3 result = without_green + green_modified;
	
	COLOR.rgb = result;
	//COLOR = vec4(result.r, result.g, result.b, COLOR.a);
	
	
	
	
	// MY SOLUTION
	//vec3 img = vec3(COLOR.r, COLOR.g, COLOR.b);
	//vec3 not_green_part = vec3(COLOR.r, 0, COLOR.b);
	//float not_green_qtd = length(not_green_part);
	//float not_green_qtd_bool = step(.01, not_green_qtd);
	//vec3 not_green_bool = vec3(not_green_qtd_bool, not_green_qtd_bool, not_green_qtd_bool);
	//
	//vec3 without_green = img*not_green_bool;
	//
	//vec3 green_bool = vec3(1., 1., 1.) - not_green_bool;
	//vec3 the_green_part = green_bool * img.g;
	//
	//vec3 def_color = vec3(241.0, 231.0, 126.0) / 256.0;
	//vec3 green_modified = def_color * the_green_part;
	//
	//vec3 result = without_green + green_modified;
	//
	//COLOR = vec4(result.r, result.g, result.b, COLOR.a);
}
