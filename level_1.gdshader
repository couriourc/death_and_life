// 滑动切换着色器 (Godot 4.x)
shader_type canvas_item;

// 1. 声明一个带有 hint_screen_texture 提示的 uniform 来获取屏幕纹理[citation:1]
uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

// 控制动画进度的参数
uniform float progress : hint_range(0.0, 1.0) = 0.5;
uniform float feather_width : hint_range(0.0, 0.5) = 0.1;

void fragment() {
    // 2. 从我们声明的 screen_texture uniform 中采样，而不是 SCREEN_TEXTURE
    //vec4 backbuffer_color = textureLod(screen_texture, SCREEN_UV, 0.0);
	COLOR = textureLod(screen_texture,fract( SCREEN_UV*10.), 0.0);

    //// 计算滑动效果（从右向左）
    //float slide_x = SCREEN_UV.x + progress;
    ////float mask = smoothstep(0.0, feather_width, slide_x);
    //COLOR = vec4(backbuffer_color.rgb , .5);
}