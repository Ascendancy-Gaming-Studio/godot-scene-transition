shader_type canvas_item;

uniform float screen_width = 1920;
uniform float screen_height = 1080;
uniform vec2 center = vec2(0.5f);
uniform vec2 player = vec2(0.5f);

uniform float progress : hint_range(0,1);
uniform float pixel_size = 15.0f;
uniform float circle_size : hint_range(0,2) = 1.5f;
uniform float curtains : hint_range(0,1) = 1.0f;

uniform int type : hint_range(0,4) = 0;


bool diamond_pixel(vec4 frag_coord, vec2 uv) {
    float fraction_x = fract(frag_coord.x / pixel_size);
    float fraction_y = fract(frag_coord.y / pixel_size);
    float distance_x = abs(fraction_x - 0.5);
    float distance_y = abs(fraction_y - 0.5);

    return (distance_x + distance_y + uv.x + uv.y <= progress * 4.0);
}

bool circle_to_player(vec2 uv, float ratio) {
	return (distance(player, vec2(mix(player.x, uv.x, ratio), uv.y)) < circle_size * (1.0 - progress));
}

bool circle_center(vec2 uv, float ratio) {
	return (distance(center, vec2(mix(center.x, uv.x, ratio), uv.y)) < circle_size * (1.0 - progress));
}

bool vertical_cut(vec2 uv) {
    return (distance(vec2(0.5), vec2(uv.x, uv.x)) >= curtains * (1.0 - progress));
}

bool horizontal_cut(vec2 uv) {
    return (distance(vec2(0.5), vec2(uv.y, uv.y)) >= curtains * (1.0 - progress));
}

void fragment() {
	float ratio = screen_width / screen_height;
	
	if (type == 0 && diamond_pixel(FRAGCOORD, UV.xy)) COLOR.a = 0.0f;
	else if (type == 1 && circle_to_player(UV.xy, ratio)) COLOR.a = 0.0f;
	else if (type == 2 && circle_center(UV.xy, ratio)) COLOR.a = 0.0f;
	else if (type == 3 && vertical_cut(UV.xy)) COLOR.a = 0.0f;
	else if (type == 4 && horizontal_cut(UV.xy)) COLOR.a = 0.0f;
}
