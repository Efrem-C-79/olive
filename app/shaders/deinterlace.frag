uniform sampler2D ove_maintex;
uniform vec2 ove_resolution;

in vec2 ove_texcoord;

out vec4 fragColor;

void main() {
    vec2 using_texcoord = ove_texcoord;

    // A very basic deinterlace that halves the vertical
    // resolution and linearly interpolates the two fields
    // by reading the texture coord between them.
    float half_vert = round(ove_resolution.y / 2.0);
    using_texcoord.y = (round(using_texcoord.y * half_vert) + 0.25) / half_vert;

    vec4 color = %1(texture(ove_maintex, using_texcoord));
    fragColor = color;
}
