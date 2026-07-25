extends Area2D

func _ready() -> void:
	global_position = global_position


func _process(delta: float) -> void:
	await get_tree().create_timer(1).timeout
	queue_free()


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemy"):
		print("hit enemy")
		queue_free()
