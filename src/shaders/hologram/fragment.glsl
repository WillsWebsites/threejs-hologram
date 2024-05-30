uniform float uTime;
uniform vec3 uColor;

varying vec3 vPosition;
varying vec3 vNormal;

void main() {
    // Normal
    vec3 normal = normalize(vNormal);
    if(!gl_FrontFacing)
        normal *= -1.0;

    // Stripes
    float stripes = mod((vPosition.y + uTime * 0.02) * 25.0, 1.0);
    stripes = pow(stripes, 3.0);

    // Fresnel
    vec3 viewPosition = normalize(vPosition - cameraPosition);
    float fresnel = dot(viewPosition, normal) + 1.0;
    fresnel = pow(fresnel, 2.0);

    // Falloff
    float falloff = smoothstep(0.8, 0.0, fresnel);

    // Hologram 
    float hologram = fresnel * stripes;
    hologram += fresnel * 1.15;
    hologram *= falloff;

    // Final Color
    gl_FragColor = vec4(uColor, hologram);
    #include <tonemapping_fragment>
    #include <colorspace_fragment>
}