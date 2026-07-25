extends CharacterBody2D

@export var speed: int = 200
@export var isGrounded: bool = false
@export var specialShot: int = 3
@export var score: int = 0

@onready var playerShotScene = load("res://scenes/player_shot.tscn")

func _physics_process(delta: float) -> void:

	var direction = Input.get_vector('left', 'right', 'up', 'down')
	if not isGrounded:
		if direction:
			velocity.x = direction.x * speed
			velocity.y = direction.y * speed
		else:
			velocity.x = move_toward(velocity.x, 0, speed)
			velocity.y = move_toward(velocity.y, 0, speed)

	else:
		if not is_on_floor():
			velocity += get_gravity() * delta

		if direction:
			velocity.x = direction.x * speed
		else:
			velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
	print(score)

func _input(event):

	if event is InputEventMouseButton and event.pressed:
		if event.button_index == 1:
			shoot()

		elif event.button_index == 2:
			special()

func addScore(amount):
	score += amount

func hit():
	if not isGrounded:
		isGrounded = true
	else:
		die()

func die(): # add gameOverScreen
	pass

func shoot():
	var playerShotInstance = playerShotScene.instantiate()
	playerShotInstance.add_to_group("PlayerProjectile")
	add_child(playerShotInstance)

func special():
	pass
