shader_type canvas_item;
uniform float radius : hint_range(0.0, 2.) = 0.5;

void fragment() {    
    // 获取纹理尺寸并计算长宽比
    vec2 texture_size = vec2(textureSize(TEXTURE, 0));
    float aspect = texture_size.x / texture_size.y; // 假设宽度大于高度
    
    // 修正UV：拉伸X轴，使其与Y轴的单位长度一致
    vec2 fixed_uv = (UV - vec2(0.5)) * vec2(aspect, 1.0) + vec2(0.5);
    
    float dist = length(fixed_uv - vec2(0.5));
    float mask_alpha = 1.0 - smoothstep(radius - 0.02, radius, dist);
    
    COLOR = texture(TEXTURE, UV) * vec4(1.0, 1.0, 1.0, mask_alpha);
}