shader_type spatial;
render_mode unshaded;

uniform sampler2D _texture1 : hint_albedo;
uniform sampler2D _heightmap1 : hint_white;
uniform sampler2D _texture2 : hint_albedo;
uniform sampler2D _heightmap2 : hint_white;
uniform float _heightblendFactor : hint_range(0.01, 1.0, 0.01);

vec3 heightblend(vec3 input1, float height1, vec3 input2, float height2)
{
    float height_start = max(height1, height2) - _heightblendFactor;
    float level1 = max(height1 - height_start, 0);
    float level2 = max(height2 - height_start, 0);
    return ((input1 * level1) + (input2 * level2)) / (level1 + level2);
}

void fragment() {
	
	vec3 v1 = texture(_texture1, UV).rgb;
	float h1 = texture(_heightmap1, UV).r;
	
	vec3 v2 = texture(_texture2, UV).rgb;
	float h2 = texture(_heightmap2, UV).r;
	
	ALBEDO = heightblend(v1, h1, v2, h2);
}