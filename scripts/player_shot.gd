extends Area2D

var projectileSpeed = 600.0

var origin: Vector2
var destination: Vector2


func _ready() -> void:
	global_position = global_position


func _process(delta: float) -> void:
	$AnimatedSprite2D.sprite_frames.set_animation_loop("default", false)
	$AnimatedSprite2D.play()
	print(origin)
	print(destination)
	var direction = Vector2(destination.x - origin.x, destination.y - origin.y).normalized()
	
	position += direction * projectileSpeed * delta

	if global_position.distance_to(destination) < projectileSpeed * delta:
		print("freed")
		queue_free()


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemy"):
		get_parent().addScore(50)
		queue_free()
