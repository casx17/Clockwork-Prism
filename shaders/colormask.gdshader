shader_type canvas_item;

uniform vec4 mask_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform float mask_value : hint_range(0.0, 1.0, 0.1) = 0.0;

void fragment() {
    COLOR = mix(COLOR, vec4(mask_color.rgb, COLOR.a), mask_value);
}