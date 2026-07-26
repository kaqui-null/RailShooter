extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

	if get_tree().current_scene.get_node("Player").isGrounded == true:
		text = "LIFE: DANGER"
	else:
		text = "LIFE: SAFE"
