extends Node2D

@onready var enemyScene = load("res://scenes/enemy.tscn")
@export var testEnemyType : int = 1

@onready var obstacleScene = load("res://scenes/obstaculo.tscn")
@export var testObstacleType: int = 1


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

#func _on_obstacle_timer_timeout() -> void:
#	var obstacleInstance = obstacleScene.instantiate()
#	obstacleInstance.type = testObstacleType
#	obstacleInstance.add_to_group("Obstacle")
#	add_child(obstacleInstance)
