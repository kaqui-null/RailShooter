extends Area2D

@export var speed: float = 1.0
@export var acceleration: float = 8.0
@export var type = 1

var enemyPos: Vector2 = Vector2(0,0)

var projectileOrigin: Vector2
var projectileDestination: Vector2
var projectileDirection: Vector2
@onready var projectileScene: PackedScene = load("res://scenes/projectile.tscn")

# will only work on the level root
@onready var sceneRoot = get_tree().get_root()

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

func shoot():
	var player = sceneRoot.get_node("/root/Level1/Player")
	enemyPos = player.position
	projectileOrigin = global_position
	projectileDestination = enemyPos
	projectileDirection.x = projectileDestination.x - projectileOrigin.x
	projectileDirection.y = projectileDestination.y - projectileOrigin.y


func _on_shoot_timer_timeout() -> void:
	var projectileInstance = projectileScene.instantiate()
	shoot()
	add_child(projectileInstance)
