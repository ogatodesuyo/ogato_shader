
#ifdef GL_ES
precision mediump float;
#endif

#extension GL_OES_standard_derivatives : enable

#define NUM_OCTAVES 16

uniform float time;
uniform vec2 resolution;
uniform vec2 mouse;
varying vec2 surfacePosition;

float random(vec2 pos) {
	return fract(sin(dot(pos.xy, vec2(12.9898, 78.233))) * 43758.5453123);
}

float noise(vec2 pos) {
	vec2 i = floor(pos);
	vec2 f = fract(pos);
	float a = random(i + vec2(0.0, 0.0));
	float b = random(i + vec2(1.0, 0.0));
	float c = random(i + vec2(0.0, 1.0));
	float d = random(i + vec2(1.0, 1.0));
	vec2 u = f * f * (5.0 - 2.0 * f);
	return mix(a, b, u.x) + (c - a) * u.y * (1.0 - u.x) + (d - b) * u.x * u.y;
}

float fbm(vec2 pos) {
	float v = 0.0;
	float a = 0.5;
	vec2 shift = vec2(1e4) + mouse;
	mat2 rot = mat2(cos(0.1), sin(0.5), -sin(0.5), cos(0.5));
	for (int i=0; i<NUM_OCTAVES; i++) {
		v += a * noise(pos);
		pos = ((rot * pos) * 2.0) + shift + mouse;
		a *= 0.5;
	}
	return v;
}

void main(void) {
	float minrz = min(resolution.x, resolution.y);
	vec2 p = surfacePosition;//(((vec2(2.0, 2.0) * gl_FragCoord.xy) - resolution.xy) * vec2((1.0 / min(resolution.x, resolution.y)), (1.0 / min(resolution.x, resolution.y))));

	float t = 0.0;
	
	float time2 = 3.0 * time / 2.0;
	
	vec2 q = vec2(0.0);
	q.x = fbm(p + 0.00);
	q.y = fbm(p + vec2(1.0));
	
	gl_FragColor = vec4(vec3(noise(p + vec2(1.0)),
				 noise(p + 1.0 * q + vec2(1.7, 9.2) + 0.15 * time2),
				 noise(p + 1.0 * q + vec2(8.3, 2.8) + 0.126 * time2)),1.0);