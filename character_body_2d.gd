extends CharacterBody2D

# Velocidad de movimiento del personaje
@export var speed: float = 150.0

# Asigna este nodo arrastrándolo desde la escena al Inspector
@export var animated_sprite: AnimatedSprite2D

# Guarda la última dirección (por defecto mira hacia abajo)
var ultima_direccion: Vector2 = Vector2.DOWN

func _physics_process(delta: float) -> void:
	var input_direction := Vector2.ZERO

	# Comprobar si las teclas están presionadas
	if Input.is_action_pressed("ui_right"):
		input_direction.x += 1
	if Input.is_action_pressed("ui_left"):
		input_direction.x -= 1
	if Input.is_action_pressed("ui_down"):
		input_direction.y += 1
	if Input.is_action_pressed("ui_up"):
		input_direction.y -= 1

	# Normalizar para que no se mueva más rápido en diagonal
	if input_direction != Vector2.ZERO:
		input_direction = input_direction.normalized()
		ultima_direccion = input_direction

	# Aplicar movimiento
	velocity = input_direction * speed
	move_and_slide()

	# Gestionar animaciones
	actualizar_animacion(input_direction)

func actualizar_animacion(direction: Vector2) -> void:
	if animated_sprite == null:
		return

	# Usar la dirección actual o la última registrada al detenerse
	var dir_a_usar = direction if direction != Vector2.ZERO else ultima_direccion

	if dir_a_usar.y > 0:
		animated_sprite.play("caminar_abajo")
	elif dir_a_usar.y < 0:
		animated_sprite.play("caminar_arriba")
	elif dir_a_usar.x != 0:
		animated_sprite.play("caminar_lados")
		animated_sprite.flip_h = (dir_a_usar.x > 0)

	# Si se detiene, pausa el sprite en el primer fotograma
	if direction == Vector2.ZERO:
		animated_sprite.stop()
		animated_sprite.frame = 0
