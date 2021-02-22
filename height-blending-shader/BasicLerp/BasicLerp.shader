shader_type spatial;
render_mode unshaded;

uniform sampler2D _texture1 : hint_albedo;
uniform sampler2D _texture2 : hint_albedo;

void fragment() {
	
	vec3 v1 = texture(_texture1, UV).rgb;
	vec3 v2 = texture(_texture2, UV).rgb;
	
	float t = UV.x;
	
	ALBEDO = mix(v1, v2, t);
}