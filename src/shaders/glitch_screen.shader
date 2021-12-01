shader_type canvas_item;

uniform float shake_power = 0.1;
uniform float shake_rate : hint_range( 0.0, 10.0 ) = 8.0;
uniform float n_stripes = 80.0;
uniform float chromatic_aberration : hint_range(0.0, 1.0) = 0.02;
uniform float rgb_opacity: hint_range(0.0, 1.0) = 0.5;

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

float calculate_stripe_dir(vec2 uv, float t, float num_stripes, float stripe_freq) {
	float stripe_id = floor(uv.y * num_stripes);
	return step(stripe_freq, hash11(stripe_id + floor(t)));
}

void fragment( )
{
	float t = TIME * shake_rate;

	vec2 uv = SCREEN_UV;
	float num_right_stripes = n_stripes / 2.0;
	float num_left_stripes = n_stripes;
	float right_stripe_freq = 0.6;
	float left_stripe_freq = 0.4;
	
	float right_stripe = calculate_stripe_dir(uv, t * 2.0, num_right_stripes, right_stripe_freq);
	float left_stripe = calculate_stripe_dir(uv, t * -3.0, num_left_stripes, left_stripe_freq);
	
	uv.x += hash11(floor(t)) * (right_stripe - left_stripe) * shake_power;
	
	float r = texture(SCREEN_TEXTURE, uv + chromatic_aberration).r;
	float g =  texture(SCREEN_TEXTURE, uv).g;
	float b = texture(SCREEN_TEXTURE, uv - chromatic_aberration).b;
	vec4 color = vec4(r, g, b, rgb_opacity);
	COLOR = color;
}