shader_type canvas_item;

uniform float size : hint_range(0.001, 0.1) = 0.001;

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
	vec2 uv = SCREEN_UV;
	//uv -= mod(uv, vec2(size, size));
	vec2 ipos = floor(uv / size);

	vec3 color = vec3(hash21(ipos + hash11(TIME)));
	COLOR = vec4(color, 1.0);
}
