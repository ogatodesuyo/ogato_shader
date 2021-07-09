#ifdef GL_ES
precision mediump float;
#endif

uniform float time;
uniform vec2 mouse;
uniform vec2 resolution;


float speed(vec2 uv){
	
	float distanceCenter = sqrt(uv.x*uv.x + uv.y*uv.y);
	
	float speed = max(0.3, 0.005 -distanceCenter/min(resolution.x,resolution.y));
	
	return speed;
}

void main( void ) {
	vec2 uv = ( 2.0 * gl_FragCoord.xy - resolution.xy ) / min(resolution.x, resolution.y );

	vec3 color = vec3(0.2, 0.21, 0.7);
	
	float r = sqrt(uv.y*uv.y + uv.y*uv.y);
	
	float z = sin(r*time*speed(uv)*240.)/r;
	
	color = color*z;
	
	

	gl_FragColor = vec4( color, 1.0 );

}
