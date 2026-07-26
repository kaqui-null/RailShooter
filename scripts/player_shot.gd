extends Area2D

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	await get_tree().create_timer(2).timeout
	queue_free()


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemy"):
		get_parent().addScore(50)
		queue_free()
