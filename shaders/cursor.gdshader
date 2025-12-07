shader_type canvas_item;

uniform float opacity;

// Ease In-Out (先加速后减速) - 最常用
float ease_in_out(float t) {
    if (t < 0.5) {
        return 2.0 * t * t;
    } else {
        return 1.0 - pow(-2.0 * t + 2.0, 2.0) / 2.0;
    }
}

void fragment() {
	// Called for every pixel the material is visible on.
    vec4 color = texture(TEXTURE, UV);
	
    // 创建 0-1 循环
    float t = fract(TIME / 2.);
    // 转换为 0-1-0 (淡入淡出)
    t = abs(t * 2.0 - 1.0);
    // 应用缓动
    float animated_alpha = ease_in_out(t);
	COLOR = color* opacity*animated_alpha;
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
