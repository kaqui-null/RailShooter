extends Area2D

@export var speed: float = 1.0
@export var acceleration: float = 8.0
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

	enemyPathingSpecification()

func enemyPathingSpecification():
	if type == 1:
		acceleration = 0
		speed = 0
		origin = spawners[randi()%7].position
		destination = spawners[randi()%7].position
	elif type == 2:
		origin = spawners[0].position
		destination = spawners[randi()%7].position
	elif type == 3:
		var final = randi() % 2 # (0 ou 1)
		origin = spawners[final + 1].position
		if final == 0:
			destination = spawners[5].position
		else:
			destination = spawners[4].position
	elif type == 5:
		origin = spawners[3].position
		destination = spawners[6].position
	else:
		destination = spawners[1].position
		origin = spawners[0].position
	global_position = origin

func _process(delta: float) -> void:
	var direction = Vector2(destination.x - origin.x, destination.y - origin.y).normalized()
	speed += acceleration * delta

	global_position += direction * speed

	if global_position.distance_to(destination) < speed * delta:
		queue_free()
