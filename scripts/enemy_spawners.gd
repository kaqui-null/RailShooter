extends Node2D

@onready var enemyScene = load("res://scenes/enemy.tscn")
@export var testEnemyType : int = 1

@onready var obstacleScene = load("res://scenes/obstaculo.tscn")
@export var testObstacleType: int = 1

@onready var itemScene = load("res://scenes/itens.tscn")

func _process(delta: float) -> void:
	pass

#func _on_timer_timeout() -> void:
#	var enemyInstance = enemyScene.instantiate()
#	enemyInstance.type = testEnemyType
#	enemyInstance.add_to_group("Enemy")
#	add_child(enemyInstance)

func spawn_n_enemies(n, type):
	var enemyInstance
	for i in range(n):
		enemyInstance = enemyScene.instantiate()
		enemyInstance.type = type
		enemyInstance.add_to_group("Enemy")
		add_child(enemyInstance)

func _on_obstacle_timer_timeout() -> void:
	var obstacleInstance = obstacleScene.instantiate()
	obstacleInstance.type = randi()%3 + 1
	obstacleInstance.add_to_group("Obstacle")
	add_child(obstacleInstance)


func _on_item_timer_timeout() -> void:
	var itensInstance = itemScene.instantiate()
	print("spawned Item")
	itensInstance.type = randi()%2 + 1
	itensInstance.add_to_group("Itens")
	add_child(itensInstance)
