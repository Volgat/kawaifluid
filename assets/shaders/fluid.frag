#version 460 core
#include <flutter/runtime_effect.glsl>

precision mediump float;

uniform vec2 uSize;
uniform float uTime;
uniform vec2 uTouch;
uniform float uTouchStrength;
uniform vec3 uColor1;
uniform vec3 uColor2;
uniform vec3 uColor3;

out vec4 fragColor;

// Noise function pour le fluide
float noise(vec2 p) {
    return fract(sin(dot(p, vec2(12.9898, 78.233))) * 43758.5453);
}

float smoothNoise(vec2 p) {
    vec2 i = floor(p);
    vec2 f = fract(p);
    f = f * f * (3.0 - 2.0 * f);
    
    float a = noise(i);
    float b = noise(i + vec2(1.0, 0.0));
    float c = noise(i + vec2(0.0, 1.0));
    float d = noise(i + vec2(1.0, 1.0));
    
    return mix(mix(a, b, f.x), mix(c, d, f.x), f.y);
}

// Fractal Brownian Motion pour effet fluide
float fbm(vec2 p) {
    float value = 0.0;
    float amplitude = 0.5;
    float frequency = 1.0;
    
    for(int i = 0; i < 6; i++) {
        value += amplitude * smoothNoise(p * frequency);
        frequency *= 2.0;
        amplitude *= 0.5;
    }
    return value;
}

void main() {
    vec2 uv = FlutterFragCoord().xy / uSize;
    vec2 p = uv * 4.0;
    
    // Animation du temps
    float t = uTime * 0.3;
    
    // Déformation fluide principale
    vec2 q = vec2(
        fbm(p + vec2(0.0, t)),
        fbm(p + vec2(5.2, 1.3 + t))
    );
    
    vec2 r = vec2(
        fbm(p + 4.0 * q + vec2(1.7 - t * 0.5, 9.2)),
        fbm(p + 4.0 * q + vec2(8.3 - t * 0.3, 2.8))
    );
    
    // Interaction au toucher
    float dist = length(uv - uTouch);
    float touchEffect = smoothstep(0.3, 0.0, dist) * uTouchStrength;
    
    // Vagues créées par le toucher
    float wave = sin(dist * 20.0 - uTime * 5.0) * touchEffect;
    r += wave * 0.3;
    
    // Pattern fluide final
    float f = fbm(p + r);
    
    // Mélange de couleurs
    vec3 color = mix(uColor1, uColor2, f);
    color = mix(color, uColor3, f * f);
    
    // Ajouter de la luminosité aux zones de toucher
    color += touchEffect * 0.3;
    
    fragColor = vec4(color, 1.0);
}