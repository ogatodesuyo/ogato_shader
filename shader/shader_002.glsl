#ifdef GL_ES
precision mediump float;
#endif

uniform float time;
uniform vec2 mouse;
uniform vec2 resolution;

#define PI 3.1415926535

struct Ray {
	vec3 pos;
	vec3 dir;
};
	
float udRoundBox( vec3 p, vec3 b, float r )
{
	return length(max(abs(p)-b,0.0))-r;
}

vec3 repPos( vec3 p, vec3 c )
{
    return mod(p,c)-0.75*c;
}


float subFunc(vec3 pos)
{
	float a = mod(atan(pos.y, pos.x), PI / 1.5) - PI / 1.5 / 2.0;
	float xyLen = length(pos.xy);
	a -= pos.z;
	pos.xy = vec2(xyLen * sin(a), xyLen * cos(a));
	pos = repPos(pos, vec3(0.03));
	return udRoundBox(pos, vec3(0.0138), 0.001);
}

float func(vec3 pos)
{
	float a = mod(atan(pos.y, pos.x), PI / 1.5) - PI / 1.5 / 2.0;
	float xyLen = length(pos.xy);
	a += pos.z;
	pos.xy = vec2(xyLen * sin(a), xyLen * cos(a));
	pos = repPos(pos, vec3(0.33));
	return udRoundBox(pos, vec3(0.1), 0.01);
}

float distFunc(vec3 pos)
{
	
	return max(-subFunc(pos), func(pos));
	//return subFunc(pos);
}

vec3 getNormal(vec3 pos)
{
	const float d = 0.0001;
	return normalize(
		vec3(
			distFunc(pos + vec3(d, 0.0001, 0)) - distFunc(pos - vec3(d, 0, 0)),
			distFunc(pos + vec3(0, d, 0.0001)) - distFunc(pos - vec3(0, d, 0)),
			distFunc(pos + vec3(0.0001, 0, d)) - distFunc(pos - vec3(0, 0, d))
		)
	);
}

vec3 rayMarching(vec2 pos) {
	vec3 cameraPos = vec3(0.0, 0.0, -15.0 + time * 0.4);
	Ray ray;
	ray.pos = cameraPos;
	ray.dir = normalize(vec3(pos * 1.5, 0.6));
	float d;
	for(int i = 0; i < 64; ++i)
	{
		d = distFunc(ray.pos);
		ray.pos += d * ray.dir;
		if (abs(d) < 0.001) break;
	}
	
	float light = (dot(getNormal(ray.pos), vec3(-1, 2, 4)));
	return clamp(vec3(1.0, 0.2, 0.2) * light + (ray.pos - cameraPos).z * 0.5, 0.1, 1.2);
}

void main( void ) {

	vec2 pos1 = (gl_FragCoord.xy + vec2(1.2, 0.0) - resolution * 0.8)  / resolution.y + mouse - 0.6;
	vec2 pos2 = (gl_FragCoord.xy + vec2(0.8, 0.5) - resolution * 0.8)  / resolution.y + mouse - 0.6;
	vec2 pos3 = (gl_FragCoord.xy + vec2(0.6, 0.0) - resolution * 0.8)  / resolution.y + mouse - 0.6;
	vec2 pos4 = (gl_FragCoord.xy + vec2(1.0, 1.0) - resolution * 0.8)  / resolution.y + mouse - 0.6;
	gl_FragColor = vec4(vec3(rayMarching(pos1)), 1.2);
	return;
	gl_FragColor = 
		vec4(
			(rayMarching(pos1) + 
			rayMarching(pos2) + 
			rayMarching(pos3) + 
			rayMarching(pos4)) / 3.0
		, 1.5);
}