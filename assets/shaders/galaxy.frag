
#version 300 es
precision mediump float;

uniform vec2 iResolution;
uniform float iTime;
uniform vec2 iMouse;

in vec2 v_coords;

out vec4 fragColor;

// Noise functions
float random(vec2 st) {
    return fract(sin(dot(st.xy, vec2(12.9898, 78.233))) * 43758.5453123);
}

float noise(vec2 st) {
    vec2 i = floor(st);
    vec2 f = fract(st);
    vec2 u = f*f*(3.0-2.0*f);
    return mix(random(i + vec2(0.0,0.0)),
               random(i + vec2(1.0,0.0)), u.x) +
           (random(i + vec2(0.0,1.0)) - random(i + vec2(0.0,0.0))) * u.y * (1.0 - u.x) +
           (random(i + vec2(1.0,1.0)) - random(i + vec2(1.0,0.0))) * u.x * u.y;
}

// Fractional Brownian Motion for more complex noise
float fbm(vec2 st) {
    float value = 0.0;
    float amplitude = 0.5;
    for (int i = 0; i < 6; i++) {
        value += amplitude * noise(st);
        st *= 2.;
        amplitude *= 0.5;
    }
    return value;
}

void main() {
    vec2 uv = (v_coords.xy / iResolution.xy) * 2.0 - 1.0;
    uv.x *= iResolution.x / iResolution.y;

    float speed = 0.1;
    float t = iTime * speed;

    // Distort the coordinates
    vec2 q = vec2(fbm(uv + t), fbm(uv + vec2(1.0)));

    // Create a base pattern
    float base_pattern = fbm(uv + q * 0.5);

    // Define the pastel color palette from the image
    vec3 color1 = vec3(0.6, 0.8, 1.0); // Light Blue
    vec3 color2 = vec3(0.9, 0.7, 0.8); // Pink
    vec3 color3 = vec3(0.8, 0.75, 0.95); // Lavender

    // Mix colors based on the pattern
    vec3 col = mix(color1, color2, smoothstep(0.3, 0.6, base_pattern));
    col = mix(col, color3, smoothstep(0.5, 0.8, fbm(uv - t)));

    // Add some brighter highlights
    float highlights = smoothstep(0.7, 0.9, fbm(uv + t + q));
    col += highlights * vec3(1.0, 1.0, 1.0);

    fragColor = vec4(col, 1.0);
}
