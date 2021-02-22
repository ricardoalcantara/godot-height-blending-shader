shader_type spatial;
render_mode unshaded;

uniform sampler2D _texture1 : hint_albedo;
uniform sampler2D _heightmap1 : hint_white;
uniform sampler2D _texture2 : hint_albedo;
uniform sampler2D _heightmap2 : hint_white;
uniform float _heightblendFactor : hint_range(0.01, 1.0, 0.01);

uniform float _uv_scale : hint_range(0.1, 10.0, 0.1);
uniform float _uv_height_scale : hint_range(0.1, 10.0, 0.1);

vec3 heightblend(vec3 input1, float height1, vec3 input2, float height2)
{
    float height_start = max(height1, height2) - _heightblendFactor;
    float level1 = max(height1 - height_start, 0);
    float level2 = max(height2 - height_start, 0);
    return ((input1 * level1) + (input2 * level2)) / (level1 + level2);
}


vec3 heightlerp(vec3 input1, float height1, vec3 input2, float height2, float t)
{
    t = clamp(t, 0.0, 1.0);
    return heightblend(input1, height1 * (1.0 - t), input2, height2 * t);
}

void fragment() {
	
	vec2 uv = UV * _uv_scale;
	vec2 uv_height = UV * _uv_height_scale;
	vec3 v1 = texture(_texture1, uv).rgb;
	float h1 = texture(_heightmap1, uv_height).r;
	
	vec3 v2 = texture(_texture2, uv).rgb;
	float h2 = texture(_heightmap2, uv_height).r;
	
	float t = UV.x;
	
	ALBEDO = heightblend(v1, h1, v2, h2);
//	ALBEDO = heightlerp(v1, h1, v2, h2, t);
}