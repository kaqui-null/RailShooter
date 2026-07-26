extends Node2D

@onready var youWonScene = preload("res://scenes/finished_level_screen.tscn")

# cadencia 1, 2, 3
var waves = [
	3, 3, 3,
	2, 2, 2, 2, 2,
	1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
	]

var waveDelay = [0, 0.5, 1.5, 3]
var elapsed = 0.0

@onready var currLevel = get_parent().name


func _ready() -> void:
	pass

func _process(delta: float) -> void:

	elapsed += delta
	if elapsed >= 3.0:
		print(elapsed)
		spawn()
		elapsed = 0.0

func spawn():
	print(waves)
	var spawner = get_tree().current_scene.get_node("EnemySpawners")
	#var spawnerEnemyTimer = spawner.get_node("Timer")
	var cadence
	if waves.size() == 0:
		GameGlobals.levelIndex += 1
		get_tree().change_scene_to_packed(youWonScene)
	elif waves.size() == 1:
		cadence = waves.pop_at(0)
	else:
		cadence = waves.pop_at(randi()%waves.size())

	if cadence == 3:
		spawner.spawn_n_enemies(randi()%2+4, [2,3].pick_random())
		print("hit cadence 3")
	elif cadence == 2:
		spawner.spawn_n_enemies(randi()%2+1, [1,2,5].pick_random())
		print("hit cadence 2")
	elif cadence == 1:
		spawner.spawn_n_enemies(1, [1,2,3,5].pick_random())
		print("hit cadence 1")
	else:
		pass
