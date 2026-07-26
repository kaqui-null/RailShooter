extends Area2D

@export var speed: float = 1.0
@export var acceleration: float = 1.5
@export var type = 1 # 1 - bomba, 2 - vida, 3 - continue

@export var spawners : Array = [
	"SpawnCenter",
	"SpawnTopLeft",
	"SpawnTopRight",
	"SpawnTopCenter",
	"SpawnBottomLeft",
	"SpawnBottomRight",
	"SpawnBottomCenter",
	]

var destination
var origin

func _ready() -> void:
	$AnimatedSprite2D.animation = str(type)
	var spawnerPaths = get_parent()
	for i in range(spawners.size()):
		spawners[i] = spawnerPaths.get_node(spawners[i])

	itemPathingSpecification()

func itemPathingSpecification():
	origin = spawners[0].position
	destination = spawners[randi()%3 + 4].position

	global_position = origin

func _process(delta: float) -> void:
	var direction = Vector2(destination.x - origin.x, destination.y - origin.y).normalized()
	speed += acceleration * delta
	global_position += direction * speed

	if global_position.distance_to(destination) < speed * delta:
		queue_free()

	if acceleration == 0:
		await get_tree().create_timer(3).timeout
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		if type == 1:
			body.bombs += 1
		elif type == 2:
			body.isGrounded = false
		queue_free()
