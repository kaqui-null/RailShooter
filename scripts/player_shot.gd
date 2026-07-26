extends Area2D

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	$AnimatedSprite2D.sprite_frames.set_animation_loop("default", false)
	$AnimatedSprite2D.play()
	await get_tree().create_timer(2).timeout
	queue_free()


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemy"):
		get_parent().addScore(50)
		queue_free()
