extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if GameGlobals.levelIndex == 0:
		text = "STAGE 1"
	elif GameGlobals.levelIndex == 1:
		text = "STAGE 2"
	elif GameGlobals.levelIndex == 2:
		text = "STAGE 3"
