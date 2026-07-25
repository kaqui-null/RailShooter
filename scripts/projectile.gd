extends Area2D

@export var projectileSpeed:float = 600.0

@onready var parent = get_parent()
@onready var origin = parent.projectileOrigin
@onready var destination = parent.projectileDestination
@onready var direction = parent.projectileDirection.normalized()

func _ready():
	global_position = global_position


func _process(delta: float) -> void:
	global_position += direction * projectileSpeed * delta

	if global_position.distance_to(destination) < projectileSpeed * delta:
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		print("hit player")
		body.hit()
		queue_free()
