extends Sprite2D

var scroll := 0.0

func _process(delta):
	scroll += delta * 0.4
	material.set_shader_parameter("speed", scroll)
