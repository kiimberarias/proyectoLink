extends CharacterBody2D

# Velocidad de movimiento del personaje
@export var speed: float = 150.0

# Referencia al nodo de las animaciones (AnimatedSprite2D)
@onready var animated_sprite: AnimatedSprite2D = $"../AnimatedSprite2D"

func _physics_process(delta: float) -> void:
	# Obtener la dirección según las teclas de flecha o WASD
	var input_direction := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	# Aplicar movimiento
	velocity = input_direction * speed
	move_and_slide()
	
	# Gestionar animaciones
	actualizar_animacion(input_direction)

func actualizar_animacion(direction: Vector2) -> void:
	if direction == Vector2.ZERO:
		# Si está quieto, reproduce la animación por defecto o pausa el sprite
		animated_sprite.play("default")
		return

	# Control según la dirección del movimiento
	if direction.y > 0:
		animated_sprite.play("caminar_abajo")
	elif direction.y < 0:
		animated_sprite.play("caminar_arriba")
	elif direction.x != 0:
		animated_sprite.play("caminar_lados")
		animated_sprite.flip_h = (direction.x < 0)
