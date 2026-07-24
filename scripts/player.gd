extends CharacterBody2D

@export var speed: int = 200
@export var movState: String = "running"
@export var specialShot: int = 3


func _physics_process(delta: float) -> void:


	var direction = Input.get_vector('left', 'right', 'up', 'down')
	if movState == "flying":
		if direction:
			velocity.x = direction.x * speed
			velocity.y = direction.y * speed
		else:
			velocity.x = move_toward(velocity.x, 0, speed)
			velocity.y = move_toward(velocity.y, 0, speed)

	elif movState == "running":
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
			shoot(event.position)
		elif event.button_index == 2:
			special()

func shoot(position):
	print(position)

func special():
	print('special shot')
