
#version 300 es
precision mediump float;

uniform vec2 iResolution;
uniform float iTime;
uniform vec2 iMouse;

in vec2 v_coords;

out vec4 fragColor;

// --------[UTILS]----------------------------------------------------------------------------------
#define PI 3.14159265359
#define TAU 6.28318530718

// --------[SETTINGS]-------------------------------------------------------------------------------
#define ADD_HEART
#define ADD_SPARKLES
#define MOVING_HEART

// --------[SHAPES]---------------------------------------------------------------------------------
float heart(vec2 p) {
    p.y *= 1.2 - abs(p.x) * 0.5;
    p.x *= 1.5;
    p *= 1.1;

    float a = atan(p.x, p.y) / PI;
    float r = length(p);
    float rr = pow(r, .4);
    float f = pow(rr, 5.0) * (1.0 + .1 * sin(a * PI * 1.0 + iTime * 20.0));
    return clamp(f, 0.0, 1.0);
}

// --------[NOISE]----------------------------------------------------------------------------------
float random(vec2 st) {
    return fract(sin(dot(st.xy, vec2(12.9898, 78.233))) * 43758.5453123);
}

float noise(vec2 st) {
    vec2 i = floor(st);
    vec2 f = fract(st);

    float a = random(i);
    float b = random(i + vec2(1.0, 0.0));
    float c = random(i + vec2(0.0, 1.0));
    float d = random(i + vec2(1.0, 1.0));

    vec2 u = f * f * (3.0 - 2.0 * f);
    return mix(a, b, u.x) + (c - a) * u.y * (1.0 - u.x) + (d - b) * u.x * u.y;
}

// --------[FLUID]----------------------------------------------------------------------------------
float fluid(vec2 uv, float scale, float speed, float complexity) {
    uv *= scale;
    float t = iTime * speed;
    float d = 0.0;

    for (int i = 0; i < 5; i++) {
        uv = vec2(
            uv.x * 1.5 - sin(uv.y + t) * complexity,
            uv.y * 1.5 - cos(uv.x + t) * complexity
        );
        d += noise(uv + t);
    }
    return d;
}

// --------[MAIN]-----------------------------------------------------------------------------------
void main() {
    vec2 uv = (v_coords - 0.5 * iResolution.xy) / iResolution.y;
    vec2 mouse = (iMouse - 0.5 * iResolution.xy) / iResolution.y;

    // Fluid simulation
    float f = fluid(uv, 1.5, 0.3, 0.5);

    // Color palette
    vec3 col1 = vec3(0.9, 0.7, 0.8);
    vec3 col2 = vec3(0.6, 0.8, 1.0);
    vec3 col = mix(col1, col2, f);

    // Add heart
    #ifdef ADD_HEART
        #ifdef MOVING_HEART
            vec2 heart_uv = uv - mouse;
        #else
            vec2 heart_uv = uv;
        #endif
        float h = heart(heart_uv * 4.0);
        col = mix(col, vec3(1.0, 0.8, 0.9), h);
    #endif

    // Add sparkles
    #ifdef ADD_SPARKLES
        float sparkle_size = 0.01;
        float sparkle_speed = 2.0;
        for(int i=0; i<10; i++) {
            vec2 sparkle_uv = uv + vec2(random(vec2(i, i)), random(vec2(i*2.0, i*2.0))) - 0.5;
            sparkle_uv.x += sin(iTime * sparkle_speed + float(i)) * 0.2;
            sparkle_uv.y += cos(iTime * sparkle_speed + float(i)) * 0.2;
            float sparkle = smoothstep(sparkle_size, 0.0, length(sparkle_uv));
            col += sparkle * vec3(1.0, 1.0, 0.8);
        }
    #endif


    fragColor = vec4(col, 1.0);
}
