extends Node2D

@onready var enemyScene = load("res://scenes/enemy.tscn")
@export var testEnemyType : int = 1


func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	var enemyInstance = enemyScene.instantiate()
	enemyInstance.type = testEnemyType
	add_child(enemyInstance)
