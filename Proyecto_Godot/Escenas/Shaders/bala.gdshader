shader_type canvas_item;

uniform vec2 resolution = vec2(600.0, 400.0);
uniform float firework_count: hint_range(1.0, 50.0, 1.0) = 1.0;
uniform float particle_count: hint_range(1.0, 50.0, 1.0) = 1.0;
uniform float size: hint_range(1.0, 10.0, 0.1) = 2.0;
uniform float sharpen: hint_range(1.0, 10.0, 0.1) = 1.5;
uniform float speed: hint_range(1.0, 10.0, 0.1) = 2.0;
uniform float gravity: hint_range(0.1, 2.0, 0.1) = 0.9;
uniform float lifetime: hint_range(1.0, 10.0, 0.1) = 7.0;

vec2 noise(vec2 uv) {
	uv = vec2(dot(uv, vec2(127.1,311.7)), dot(uv, vec2(269.5,183.3)));
	return fract(sin(uv) * 43758.5453123) * 0.5;
}

vec3 spark(vec2 uv, vec2 position, float index, float cycle) {
	vec2 direction = noise(vec2(0.1, 0.3) * index);
	if (mod(index, 2.0) == 0.0) {
		direction.x = -direction.x;
	}
	direction.y -= cycle * gravity * 0.1;
	float shape = 1.0 / length(uv + position + direction * cycle) * size * 0.01;
	float red = shape * noise(vec2(0.1, 0.2) * index).x;
	float green = shape * noise(vec2(0.3, 0.4) * index).x;
	float blue = shape * noise(vec2(0.5, 0.6) * index).x;
	return pow(vec3(red, green, blue), vec3(sharpen));
}

vec3 firework(vec2 uv, float index) {
	vec3 color = vec3(0.0);
	vec2 position = noise(vec2(0.2, 0.4) * index);
	if (mod(index, 2.0) == 0.0) {
		position.x = -position.x;
	}
	float cycle = mod(TIME * speed, lifetime * (1.0 + noise(vec2(0.1, 0.9) * index).x));
	for (float i = 1.0; i <= particle_count; i += 1.0) {
		color += spark(uv, position, i, cycle);
	}
	return color;
}

void fragment() {
	vec2 uv = UV - 0.5;
	uv.x *= resolution.x / resolution.y;
	vec3 color = vec3(0.0);
	for (float i = 0.0; i < firework_count; i += 1.0) {
		color += firework(uv, i);
	}
	COLOR = vec4(color, 1.0);
}
