extends CharacterBody2D

@export var speed: int = 200
@export var isGrounded: bool = false
@export var specialShot: int = 3

var projectileOrigin = position
var projectileDestination = Vector2.ZERO
var projectileDirection = Vector2.ZERO

@onready var projectileScene = load("res://scenes/projectile.tscn")

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

func _input(event):

	if event is InputEventMouseButton and event.pressed:
		if event.button_index == 1:
			var projectileInstance = projectileScene.instantiate()
			shoot(event.position)
			add_child(projectileInstance)

		elif event.button_index == 2:
			special()

func hit():
	pass

func die():
	if hit() and isGrounded == true:
		pass

func shoot(pos):
	projectileOrigin = position
	projectileDestination = pos
	projectileDirection.x = projectileDestination.x - projectileOrigin.x
	projectileDirection.y = projectileDestination.y - projectileOrigin.y

func special():
	pass
