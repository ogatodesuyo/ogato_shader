#ifdef GL_ES
precision mediump float;
#endif

uniform float time;
uniform vec2 resolution;

#define iTime time
#define iResolution vec3(resolution,1.)

#define R(p,a,r)mix(a*dot(p,a),p,sin(r))+tan(r)*cross(p,a)
#define H(h)(cos((h)*6.3+vec3(0,23,7))*.5+.5)
void mainImage(out vec4 O, vec2 C)
{
    O=vec4(0);
    vec3 p,q,r=iResolution,
    d=normalize(vec3((C-.5*r.xy)/r.y,1));  
    float s,e,g=0.;
    for(float i=0.;i<160.;++i)
    {
        p=g*d;
        p.z-=2.;
        p=R(p,normalize(vec3(1,2,3)),iTime*.1);
        s=2.;
        for(int i=0;i<12;++i){
            p=.5-abs(p-.6);
            p.x<p.z?p=p.zyx:p;
            p.z<p.y?p=p.xzy:p;
            s*=e=1.3;
            p=abs(p)*e-vec3(0.5,2,1);
        }
        g+=e=abs(p.z)/s;
        O.xyz+=mix(vec3(1),H(g*.15),.8)*.01*exp(-10./e/i/i);
    }
}


void img(void)
{
    mainImage(gl_FragColor, gl_FragCoord.xy);
    gl_FragColor.a = -15.;
}