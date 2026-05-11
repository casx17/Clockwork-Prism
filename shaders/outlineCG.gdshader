shader_type canvas_item;

uniform vec4 outline_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform float outline_width : hint_range(0.0, 10.0) = 2.0;
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

void fragment() {
    // Read the CanvasGroup's texture
    vec4 col = texture(TEXTURE, UV);
    
    // Calculate outline based on alpha threshold
    vec2 size = SCREEN_PIXEL_SIZE * outline_width;
    
    // Sample surrounding pixels to detect edges
    float alpha = texture(TEXTURE, UV + vec2(size.x, 0.0)).a;
    alpha += texture(TEXTURE, UV + vec2(-size.x, 0.0)).a;
    alpha += texture(TEXTURE, UV + vec2(0.0, size.y)).a;
    alpha += texture(TEXTURE, UV + vec2(0.0, -size.y)).a;
    
    // Combine edges and original texture
    float outline_alpha = min(1.0, ceil(alpha)) - col.a;
    vec4 outline = outline_color;
    outline.a *= outline_alpha;
    
    // Output final color
    COLOR = mix(col, outline, outline_alpha);
}