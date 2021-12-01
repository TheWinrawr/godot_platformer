shader_type canvas_item;

uniform float size : hint_range(0.001, 0.1) = 0.001;
uniform float opacity : hint_range(0.0, 1.0) = 1.0;

void fragment() {
	vec2 uv = SCREEN_UV;
	uv -= mod(uv, vec2(size, size));
	
	vec3 color = texture(SCREEN_TEXTURE, uv).rgb;
	COLOR.rgb = mix(color, COLOR.rgb, opacity);

	//COLOR.rgb = textureLod(SCREEN_TEXTURE, uv, 0.0).rgb;
}
