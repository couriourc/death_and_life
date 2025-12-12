shader_type canvas_item;
uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;
uniform float radius: hint_range(0.0, 1.5) = 0.5;

void fragment() {
	// Called for every pixel the material is visible on.
	COLOR = textureLod(screen_texture,fract( SCREEN_UV*10.), 0.0);
	//COLOR = screen;
	vec2 texture_size = vec2(textureSize(screen_texture, 0));
    float aspect = texture_size.x / texture_size.y; // 假设宽度大于高度
  	vec2 fixed_uv = (UV - vec2(0.5)) * vec2(aspect, 1.0) ;

	//COLOR = vec4(vec3(1.),smoothstep(0.5,0.4,length(fixed_uv)));
	COLOR = vec4(vec3(1.),step(length(fixed_uv),radius));
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
