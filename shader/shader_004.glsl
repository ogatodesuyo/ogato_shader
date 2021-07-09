#ifdef GL_ES
precision mediump float;
#endif

uniform float time;
uniform vec2 mouse;
uniform vec2 resolution;

float blur = 0.005;
float pi = atan(1.)*4.;
float circleSize = 0.3;

struct Circle
{
	vec2 pos;
	float r;
};

vec2 cnorm(vec2 v)
{
	return v/max(abs(v.x),abs(v.y));	
}

float Process(Circle g,vec2 p)
{
	p-=g.pos;
	float an = atan(p.x,p.y);
	float ra = length(p);
	
	vec2 cs = vec2(cos(an),sin(an));
	cs = cnorm(cs);
	
	return smoothstep(0.07, 0.402, distance(p, vec2(0., 0.)))*smoothstep(g.r+blur,g.r,ra);
}

void main( void ) {

	vec2 res = vec2(resolution.x/resolution.y,1.);
	vec2 p = ( gl_FragCoord.xy / resolution.y )-(res/2.);
	
	float radiusX  = p.x/resolution.x;
	float radiusY  = p.y/resolution.y;
	
	float a = atan(p.x,p.y)+time;
	float r = length(p);

	vec3 c = vec3(0.0);
	
	float pi = 3.14159265;
	

	Circle g0 = Circle(vec2(radiusX+cos(time + pi/6.)/2.,radiusY+sin(time + pi/6.)/6.),circleSize);
	Circle g1 = Circle(vec2(radiusX+cos(time)/2.,radiusY+sin(time)/6.),circleSize);
	Circle g2 = Circle(vec2(radiusX+cos(time + 2.*pi/6.)/2.,radiusY+sin(time + 2.*pi/6.)/6.),circleSize);
	Circle g3 = Circle(vec2(radiusX+cos(time + 3.*pi/6.)/2.,radiusY+sin(time + 3.*pi/6.)/6.),circleSize);
	Circle g4 = Circle(vec2(radiusX+cos(time + 4.*pi/6.)/2.,radiusY+sin(time + 4.*pi/6.)/6.),circleSize);
	Circle g5 = Circle(vec2(radiusX+cos(time + 5.*pi/6.)/2.,radiusY+sin(time + 5.*pi/6.)/6.),circleSize);
	Circle g6 = Circle(vec2(radiusX+cos(time + pi)/2.,radiusY+sin(time + pi)/6.),circleSize);
	
	c = Process(g0,p)*vec3(1,2.,0.);
	c += Process(g1,p)*vec3(1.,1.,0.);
	c += Process(g2,p)*vec3(1.,0.,1.);
	c += Process(g3,p)*vec3(0.,0.,1.);
	c += Process(g4,p)*vec3(0.4,0.7,.2);
	c += Process(g5,p)*vec3(0.,1.,1.);
	c += Process(g6,p)*vec3(0.,0.42,0.45);
	
	gl_FragColor = vec4( vec3( c ), 1.0 );

}