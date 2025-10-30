
#version 300 es
precision mediump float;

uniform vec2 iResolution;
uniform float iTime;
uniform vec2 iMouse;

in vec2 v_coords;

out vec4 fragColor;

// Noise function
float random(vec2 st) {
    return fract(sin(dot(st.xy, vec2(12.9898, 78.233))) * 43758.5453123);
}

// Smooth noise function
float snoise(vec2 st) {
    vec2 i = floor(st);
    vec2 f = fract(st);
    vec2 u = f*f*(3.0-2.0*f);
    return mix(mix(random(i + vec2(0.0,0.0)), random(i + vec2(1.0,0.0)), u.x),
               mix(random(i + vec2(0.0,1.0)), random(i + vec2(1.0,1.0)), u.x), u.y);
}


// Lava lamp effect
float lava(vec2 uv) {
    float speed = 0.2;
    float scale = 2.0;
    float d = 0.0;

    for(int i = 1; i <= 4; i++) {
        d += snoise(uv * scale + iTime * speed * float(i)) / float(i);
    }
    return d;
}

void main() {
    vec2 uv = v_coords.xy / iResolution.xy;

    float l = lava(uv);

    // Color palette (warm, soft fire)
    vec3 color1 = vec3(1.0, 0.4, 0.2); // Orange
    vec3 color2 = vec3(0.8, 0.2, 0.6); // Purple
    vec3 color3 = vec3(1.0, 0.8, 0.6); // Light Yellow

    vec3 col = mix(color1, color2, smoothstep(0.3, 0.5, l));
    col = mix(col, color3, smoothstep(0.6, 0.7, l));

    fragColor = vec4(col, 1.0);
}
