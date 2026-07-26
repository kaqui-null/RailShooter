extends CharacterBody2D

@export var speed: int = 200
@export var isGrounded: bool = false
@export var bombs: int = 3
@export var lives: int = 2

var invincible = false

@onready var playerShotScene = load("res://scenes/player_shot.tscn")
var gameOverScene = preload("res://scenes/game_over.tscn")

func _physics_process(delta: float) -> void:
	# invincibilidade
	#isGrounded = false


	if velocity.x < 0:
		$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D.play("left")
	elif velocity.x > 0:
		$AnimatedSprite2D.flip_h = true
		$AnimatedSprite2D.play("left")
	else:
		$AnimatedSprite2D.play("default")

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
			var audioPlayer = AudioStreamPlayer.new()
			audioPlayer.stream = load("res://assets/music/sfx/Tiro.wav")
			add_child(audioPlayer)
			audioPlayer.play()
			audioPlayer.finished.connect(audioPlayer.queue_free)

			shoot(get_global_mouse_position())

		elif event.button_index == 2:
			special()

func addScore(amount):
	GameGlobals.score += amount

func hit():
	if invincible:
		return
	var audioPlayer = AudioStreamPlayer.new()
	audioPlayer.stream = load("res://assets/music/sfx/Player Tomando Dano.wav")
	add_child(audioPlayer)
	audioPlayer.play()
	audioPlayer.finished.connect(audioPlayer.queue_free)

	invincible = true
	$InvincibilityTimer.start()
	if not isGrounded:
		isGrounded = true
	else:
		$AnimatedSprite2D.sprite_frames.set_animation_loop("dies", false)
		$AnimatedSprite2D.play("dies")
		die()

func die(): # add gameOverScreen

	if lives > 0:
		print("continued")
		isGrounded = false
		lives -= 1

	else:
		print("dies")
		get_tree().change_scene_to_packed(gameOverScene)

func shoot(d):
	var playerShotInstance = playerShotScene.instantiate()
	playerShotInstance.add_to_group("PlayerProjectile")
	playerShotInstance.global_position = global_position
	playerShotInstance.origin = position
	print(d)
	playerShotInstance.destination = d
	playerShotInstance.top_level = true
	add_child(playerShotInstance)

func special():
	if bombs > 0:
		bombs -= 1
		for child in get_tree().current_scene.get_node("EnemySpawners").get_children():
			if child.is_in_group("Enemy"):
				child.deathState()

		GameGlobals.score += 500



func _on_invincibility_timer_timeout() -> void:
	invincible = false
