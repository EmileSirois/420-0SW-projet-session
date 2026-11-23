shader_type canvas_item;

void fragment() {
	float g = dot(COLOR.rgb, vec3(0.299, 0.587, 0.114));
	COLOR = vec4(vec3(g), COLOR.a);
}
