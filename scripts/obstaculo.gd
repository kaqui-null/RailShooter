extends Area2D

@export var speed: float = 1.0
@export var acceleration: float = 1.5
@export var type = 1

@export var spawners = [
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
	var spawnerPaths = get_parent()
	for i in range(spawners.size()):
		spawners[i] = spawnerPaths.get_node(spawners[i])

	obstaclePathingSpecification()

func obstaclePathingSpecification():
	if type == 1: # blocks top and bottom
		origin = spawners[0].position
		destination = spawners[6].position
	elif type == 2:
		speed = 0
		acceleration = 0
		var randomSpawn = randi()%3
		origin = spawners[randomSpawn + 1]
		destination = spawners[randomSpawn + 1]
	elif type == 3:
		speed = 0
		acceleration = 0
		var randomSpawn = randi()%3
		origin = spawners[randomSpawn + 4]
		destination = spawners[randomSpawn + 4]
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
