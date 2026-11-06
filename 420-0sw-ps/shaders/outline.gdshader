shader_type canvas_item;

uniform vec4 outline_color : source_color = vec4(1.0);
uniform float width = 1.0;
uniform bool active = false;

void fragment() {
	vec4 c = texture(TEXTURE, UV);
	if (active) {
		vec2 s = TEXTURE_PIXEL_SIZE * width;
		float a = texture(TEXTURE, UV + vec2(s.x, 0.0)).a
				+ texture(TEXTURE, UV - vec2(s.x, 0.0)).a
				+ texture(TEXTURE, UV + vec2(0.0, s.y)).a
				+ texture(TEXTURE, UV - vec2(0.0, s.y)).a;
		a = min(a, 1.0);
		COLOR = mix(vec4(outline_color.rgb, a * outline_color.a), c, c.a);
	} else {
		COLOR = c;
	}
}