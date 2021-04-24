shader_type spatial;
uniform sampler2D diffuse;
uniform sampler2D normal;


void vertex() {
}

void fragment() {
  ALBEDO = texture(diffuse,UV).rgb;
  NORMALMAP = texture(normal,UV).rgb;
}