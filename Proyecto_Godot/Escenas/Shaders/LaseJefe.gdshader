shader_type canvas_item;

uniform int start_frame = 0;
uniform int current_frame = 0;
uniform float mix_ratio = 1.0;

const vec3 colors[6] = vec3[] (
	vec3(1.0, 0.0, 0.0), // Red
	vec3(0.5, 0.0, 0.0), // Dark red
	vec3(0.0, 0.0, 0.0), // Black
	vec3(0.0, 0.0, 1.0), // Blue
	vec3(0.0, 0.0, 0.5), // Dark blue
	vec3(0.0, 0.0, 0.0)  // Black
);

void fragment() {
	// https://en.wikipedia.org/wiki/Rec._709#Luma_coefficients
	float brightness = dot(COLOR.rgb, vec3(0.2126, 0.7152, 0.0722));

	// Calculate the starting frame based on brightness
	int offset = 0;
	if (brightness > 0.75) {
		offset = 2;
	} else if (brightness > 0.25) {
		offset = 1;
	}

	// Get the color, wrapping around at the end of the array
	int color_index = (start_frame + current_frame + offset) % colors.length();
	vec3 color = colors[color_index];

	// Apply the color to the sprite
	COLOR = vec4(mix(COLOR.rgb, color, mix_ratio), COLOR.a);
}