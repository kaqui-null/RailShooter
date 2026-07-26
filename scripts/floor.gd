extends Node2D

@export var ground_texture: Texture2D

const SCREEN_WIDTH = 512
const SCREEN_HEIGHT = 384

const HORIZON = 192.0

const CAMERA_HEIGHT = 40.0
const FOV = 120.0

const FAR_DISTANCE = 500.0
const NEAR_DISTANCE = 5.0
const STRIPS = 160

var camera_z = 0.0
var camera_x = 0.0


func _process(delta):
	camera_z += 100.0 * delta
	queue_redraw()


func _draw():

	if ground_texture == null:
		return

	var tex_width = ground_texture.get_width()
	var tex_height = ground_texture.get_height()


	for i in range(STRIPS):
		var t = float(i) / STRIPS
		var depth = lerp(FAR_DISTANCE, NEAR_DISTANCE, t)

		var screen_y = (HORIZON + CAMERA_HEIGHT * FOV / depth)

		if screen_y >= SCREEN_HEIGHT:
			continue

		var next_depth = lerp(FAR_DISTANCE, NEAR_DISTANCE, float(i + 1) / STRIPS)

		var next_y = (HORIZON + CAMERA_HEIGHT * FOV / next_depth)

		var strip_height = next_y - screen_y

		var scale = FOV / depth

		var strip_width = SCREEN_WIDTH * scale

		var tex_y = int(camera_z + depth) % tex_height

		var curve_offset = camera_x * depth * 0.01
		draw_texture_rect_region(
			ground_texture,

			Rect2(
				SCREEN_WIDTH / 2 - strip_width / 2 + curve_offset,
				screen_y,
				strip_width,
				strip_height
			),

			Rect2(
				0,
				tex_y,
				tex_width,
				1
			)
		)
