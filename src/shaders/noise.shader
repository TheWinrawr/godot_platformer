shader_type canvas_item;

uniform float size : hint_range(0.01, 1.0) = 0.01;

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
	vec2 ipos = floor(UV / size);

	vec3 color = vec3(hash21(ipos + hash11(TIME)));
	COLOR = vec4(color, 1.0);
}
