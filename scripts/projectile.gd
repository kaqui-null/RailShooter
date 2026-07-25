extends Area2D

@export var projectileSpeed:float = 600.0

@onready var origin: Vector2
@onready var destination: Vector2
@onready var direction:Vector2

func _ready():
	global_position = origin

func _process(delta: float) -> void:
	print(direction)
	global_position += direction * projectileSpeed * delta

	if global_position.distance_to(destination) < projectileSpeed * delta:
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		#print("hit player")
		body.hit()
		queue_free()
