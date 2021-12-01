shader_type canvas_item;

uniform float cell_size : hint_range(0.0003, 1.0) = 0.5;
uniform float fade_time : hint_range(0.1, 10.0) = 4.0;
uniform float max_brightness : hint_range(0.0, 1.0) = 0.08;
uniform float cell_frequency : hint_range(0.0, 1.0) = 1.0;

float hash11(float p) {
    p = fract(p * .1031);
    p *= p + 33.33;
    p *= p + p;
    return fract(p);
}

float hash21(vec2 p) {
	vec3 p3  = fract(vec3(p.xyx) * .1031);
    p3 += dot(p3, p3.yzx + 33.33);
    return fract((p3.x + p3.y) * p3.z);
}

void fragment() {
	float t = TIME / fade_time + 30.0;
	vec2 ipos = floor(UV / cell_size);
	float t_cell = hash21(ipos) + t;

	vec3 color = vec3(hash21(ipos + hash11(floor(t_cell))));
	color *= max_brightness;
	color -= max_brightness * (1.0 - cell_frequency);
	color = mix(color, vec3(0.0), fract(t_cell));
	COLOR = vec4(color, 1.0);
}