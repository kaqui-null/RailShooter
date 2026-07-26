extends Area2D

@export var speed: float = 1.0
@export var acceleration: float = 1.5
@export var type = 1

var projectileOrigin: Vector2
var projectileDestination: Vector2
var projectileDirection: Vector2
@onready var projectileScene: PackedScene = load("res://scenes/projectile.tscn")

var dying = false

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

	if not dying:
		enemyPathingSpecification()

func enemyPathingSpecification():
	if type == 1:
		acceleration = 0
		speed = 0
		origin = spawners[randi()%7].position
		destination = spawners[randi()%7].position
		$AnimatedSprite2D.animation = "1"
	elif type == 2:
		origin = spawners[0].position
		destination = spawners[randi()%7].position
		while destination == spawners[0].position:
			destination = spawners[randi()%7].position
		$AnimatedSprite2D.animation = "2"
	elif type == 3:
		var final = randi() % 2 # (0 ou 1)
		origin = spawners[final + 1].position
		if final == 0:
			destination = spawners[5].position
		else:
			destination = spawners[4].position
		$AnimatedSprite2D.animation = "3"
	elif type == 5:
		origin = spawners[3].position
		destination = spawners[6].position
		$AnimatedSprite2D.animation = "5"
	else:
		destination = spawners[1].position
		origin = spawners[0].position
	global_position = origin

func _process(delta: float) -> void:
	if dying:
		return
	var direction = Vector2(destination.x - origin.x, destination.y - origin.y).normalized()
	speed += acceleration * delta

	$AnimatedSprite2D.scale.x += acceleration * delta * 0.7
	$AnimatedSprite2D.scale.y += acceleration * delta * 0.7
	$CollisionShape2D.scale.x += acceleration * delta * 0.7
	$CollisionShape2D.scale.x += acceleration * delta * 0.7

	global_position += direction * speed

	if global_position.distance_to(destination) < speed * delta:
		queue_free()

	# to create new animation
	if acceleration == 0:
		await get_tree().create_timer(3).timeout
		queue_free()

	await get_tree().create_timer(5).timeout
	queue_free()

func shoot():
	var player = get_parent().get_parent().get_node("Player")
	projectileOrigin = global_position
	projectileDestination = player.position
	projectileDirection.x = projectileDestination.x - projectileOrigin.x
	projectileDirection.y = projectileDestination.y - projectileOrigin.y


func _on_shoot_timer_timeout() -> void:
	var audioPlayer = AudioStreamPlayer.new()
	audioPlayer.stream = load("res://assets/music/sfx/TiroInimigo.wav")
	add_child(audioPlayer)
	audioPlayer.play()
	audioPlayer.finished.connect(audioPlayer.queue_free)
	shoot()
	var projectileInstance = projectileScene.instantiate()
	projectileInstance.origin = projectileOrigin
	projectileInstance.destination = projectileDestination
	projectileInstance.direction = projectileDirection.normalized()

	get_tree().current_scene.get_node("Projectiles").add_child(projectileInstance)


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("PlayerProjectile"):
		deathState()
func deathState():
	if dying:
		return
	dying = true
	$ShootTimer.stop()
	var audioPlayer = AudioStreamPlayer.new()
	audioPlayer.stream = load("res://assets/music/sfx/Enemy Death.wav")
	add_child(audioPlayer)
	audioPlayer.play()
	$AnimatedSprite2D.animation = "dies"
	$AnimatedSprite2D.frame = 0
	$AnimatedSprite2D.sprite_frames.set_animation_loop("dies", false)
	$AnimatedSprite2D.play("dies")
	await audioPlayer.finished
	if dying:
		await $AnimatedSprite2D.animation_finished
		dying = false


	queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
