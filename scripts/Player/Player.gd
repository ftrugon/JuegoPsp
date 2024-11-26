extends CharacterBody2D

class_name Player

@export var estadisticas: PlayerStatsManager
@export var inventario: Inventory

#variables para los inputs del movimiento
var x_dir = 0
var y_dir = 0

#para como se ve el jugador
@onready var sprite = $AnimatedSprite2D
@onready var jump_particles = $Particles/JumpPoopParticles
@onready var dash_particles = $Particles/DashPoopParticles
@onready var run_particles = $Particles/RunParticles
@onready var sliding_particles = $Particles/SlidingParticles

var actualGravity = 0

#movimiento
var can_move = true

#salto
var jump_actual_duration = 0
var jump_count = 0
var coyote_timer = 0
var input_jump = false

#slide
var is_sliding = false
var actual_time_before_sliding = 0

#dash variables
var is_dashing = false
var dash_on_cooldown = false
var actual_dash_coldown = 0
var actual_dash_duration = 0
var dash_duration_buffer = 0
var actual_dashes = 0

func _ready() -> void:
	dash_duration_buffer = estadisticas.get_max_dash_duration()
	actualGravity = estadisticas.get_gravity()

func move(delta):

	#la velocidad a la que queremos llegar
	var targetSpeed = x_dir * estadisticas.get_move_speed()

	# Calcula la diferencia entre la velocidad actual y la velocidad deseada
	var speedDif = targetSpeed - velocity.x
	
	# Cambia la tasa de aceleración dependiendo de la situación
	var accelRate
	#si la velocidad deseda es mayor(es decir que nos queremos mocer) vamos a acelerar si no es asi desacelerar
	if abs(targetSpeed) > 0.01:
		accelRate = estadisticas.get_acceleration()
	else:
		accelRate = estadisticas.get_deceleration()
	
	# Calcula la cantidad de movimiento usando una fórmula de interpolación suave(sacado de un video canal --> Dawnosaur)
	var movement = pow(abs(speedDif)*accelRate, estadisticas.get_vel_power()) * sign(speedDif)
	
	#aplica el movimiento
	
	if Input.is_action_just_pressed("dash") and can_dash() :
		is_dashing = true
		dash()
	elif input_jump and is_on_wall():
		var normal = get_wall_normal()
		
		#if normal.x > 0:
		#	print("la colision viene de la izquieda")
		#elif normal.x < 0:
		#	print("la colision viene de la derecha")
		
		#velocity.y = 100
		#velocity.x = 100
		wall_jump(normal.x)
	else:
		velocity.x += movement * delta 
	
	#Permite que el personaje se pueda mover
	move_and_slide()

"""
func tal() -> bool:
	 
	if estadisticas.get_max_jumps() <= 0:
		jump_count = estadisticas.get_max_jumps()
	
	#Si acaba de salir de una plataforma se consume el salto que se ha hecho en el suelo
	if !is_on_floor() and coyote_timer >= estadisticas.get_max_coyote_time() and jump_count == 0:
		jump_count += 1
	
	# Permitir salto si estás en el suelo o en una pared
	if is_on_floor():
		return true

	# Permitir salto en el tiempo de coyote si aún no se ha usado el salto
	if coyote_timer <= estadisticas.get_max_coyote_time() and jump_count < estadisticas.get_max_jumps():
		return true

	# Permitir salto si aún no has superado el máximo de saltos
	if jump_count < estadisticas.get_max_jumps():
		return true

	return false
	
	"""

func can_jump()->bool:
	
	#Si acaba de salir de una plataforma se consume el salto que se ha hecho en el suelo
	if !is_on_floor() and coyote_timer >= estadisticas.get_max_coyote_time() and jump_count == 0:
		jump_count += 1
		jump_actual_duration = estadisticas.get_max_jump_duration()
		
	
	#si no te quedan mas satos no pudes saltat
	if jump_count >= estadisticas.get_max_jumps():
		return false
	
	#si no estas en tiempo de coyote y estas en el primer saldo no puedes saltar
	if coyote_timer > estadisticas.get_max_coyote_time() and jump_count == 0:
		return false

	return true

func is_on_coyote_time() -> bool:
	return coyote_timer <= estadisticas.get_max_coyote_time()

func jump(delta):
	
	#la primera vez que se pulsa el salto
	if input_jump and can_jump():
		#genera las particulas de salto
		jump_particles.restart()
		#aplica el salto
		velocity.y = estadisticas.get_jump_force() / 2
		jump_actual_duration = 0
		jump_count += 1
	
	#salta mas alto si se pulsa el espacio
	if Input.is_action_pressed("Jump") and jump_actual_duration < estadisticas.get_max_jump_duration() and !is_on_wall() and !is_on_floor():
		if jump_count > 0 and jump_count <= estadisticas.get_max_jumps():
			velocity.y = estadisticas.get_jump_force()
			jump_actual_duration += delta
		
	#si suelta el espacio
	if Input.is_action_just_released("Jump"):
		jump_actual_duration = estadisticas.get_max_jump_duration()

func can_wall_jump() -> bool:
		
	#Si acaba de salir de una pared se consume el salto que se ha hecho en el suelo
	
	if is_on_floor():
		return false
	
	if is_on_ceiling():
		return false
	
	#if !is_on_wall_only() and jump_count == 0:
	#	jump_count += 1


	if jump_count > estadisticas.get_max_jumps():
		return false

	return true

func wall_jump(normal):
	if can_wall_jump():
		
		jump_particles.restart()
		
		velocity.y = estadisticas.get_wall_jump_y_force()
		velocity.x = estadisticas.get_wall_jump_x_force() * normal
		jump_actual_duration = 0
		jump_count -= 1

func can_dash() -> bool:
	
	if is_dashing:
		return false
	
	if dash_on_cooldown:
		return false
	
	if !(actual_dashes < estadisticas.get_max_dashes()):
		return false
	
	if actual_dash_coldown > estadisticas.get_max_dash_coldown():
		return false
	
	return true

func dash():
	
	actual_dashes += 1
	
	
	var to_dash_x = estadisticas.get_dash_force()
	var to_dash_y = estadisticas.get_dash_force()
	
	# Ajuste para dashes diagonales
	if x_dir != 0 and y_dir != 0:
		to_dash_x = estadisticas.get_dash_force() * 0.75
		to_dash_y = estadisticas.get_dash_force() * 0.75
		dash_duration_buffer= estadisticas.get_max_dash_duration() * 0.10
	# ajusto para solo dashear hacia arriba
	elif y_dir == -1 and !x_dir:
		to_dash_y = estadisticas.get_dash_force() * 0.75
		dash_duration_buffer= estadisticas.get_max_dash_duration() * 0.10
	else:
		dash_duration_buffer= estadisticas.get_max_dash_duration()
	
	#Si no dasheas hacia ningun lado se resetara un salto
	#if x_dir == 0 and y_dir == 0:
	#	print("--------------------------------")
	#	print(jump_count)
	#	jump_count -= 1
	#	print(jump_count)
	#	print(estadisticas.get_max_jumps())
	
	#particulas del dash
	dash_particles.restart()
	# Aplica la velocidad del dash
	velocity.x = (to_dash_x * 1.5 * x_dir)
	velocity.y = (to_dash_y * y_dir)

func inputs():
	if !is_dashing:
	
		#todos los inputs, me da pereza hacer una clase solo para esto
		x_dir = Input.get_axis("left","right")
		y_dir = Input.get_axis("Up","Down")
		input_jump = Input.is_action_just_pressed("Jump")
		
		
		#Easter egg por pulsar arriba y abajo a la vez
		if Input.is_action_pressed("ui_up") and Input.is_action_pressed("ui_down") :
			global_position.y = -10000

func on_floor_and_walls_variables_manage(delta):
	
	if is_dashing:
		dash_on_cooldown = true
		actual_dash_duration += delta
		if actual_dash_duration >= dash_duration_buffer:
			actual_dash_duration = 0
			is_dashing = false

	if dash_on_cooldown:
		actual_dash_coldown += delta
		if actual_dash_coldown >= estadisticas.get_max_dash_coldown():
			actual_dash_coldown = 0 
			dash_on_cooldown = false
	
	if is_on_floor(): 
		coyote_timer = 0
		jump_actual_duration = 0
		jump_count = 0
		actual_dashes = 0
		
	elif is_on_wall_only():
		jump_actual_duration = 0
		jump_count = 0
		actual_dashes = 0
		if velocity.y > 0:
			is_sliding = true
	else:
		is_sliding = false
		coyote_timer += delta
		actual_time_before_sliding = 0

func gravity_manage(delta):
	
	if is_dashing:
		coyote_timer = estadisticas.get_max_coyote_time()
	
	if !is_dashing:
		
		#Aplica la velocidad Y del tiempo de coyote
		if is_on_coyote_time() and !is_on_wall() and !is_on_ceiling() and velocity.y == 0:
			velocity.y = 0
			return
		
		#Si esta en el peak del salto la gravedad es menor
		if velocity.y < 5 and velocity.y > -5 and !is_on_floor() and !is_on_wall() and !is_on_ceiling():
			actualGravity = actualGravity/2
		else:
			actualGravity = ProjectSettings.get_setting("physics/2d/default_gravity")
		
		#handle sliding
		if is_sliding:
			velocity.y = 0
			actual_time_before_sliding += delta
			if actual_time_before_sliding > estadisticas.get_max_time_before_sliding():
				velocity.y = estadisticas.get_slide_speed()

		# haha extra gravity
		elif not is_on_floor(): 
			velocity.y += actualGravity * delta
			#haha more gravity if falling
			if velocity.y > 0:
				velocity.y += actualGravity * 1.5 * delta
				if velocity.y > estadisticas.get_limit_fall_speed():
					velocity.y = estadisticas.get_limit_fall_speed()

func dir():
	if x_dir != 0:
		sprite.flip_h = x_dir < 0

func animations():
	
	
	if is_on_floor():
		sprite.rotation_degrees = 0
		if x_dir != 0:
			sprite.play("Run")
		else:
			sprite.play("Idle")
	
	elif is_on_wall():
		sprite.play("Idle")
		var normal = get_wall_normal()

		if normal.x < 0:
			sprite.rotation_degrees = -15 
		
		elif normal.x > 0:
			sprite.rotation_degrees = 15 
	
	elif !is_on_floor():
		sprite.play("Jump")
		sprite.rotation_degrees = 0
	else:
		sprite.rotation_degrees = 0

func particles():
	
	
	if is_on_wall() and is_sliding and velocity.y != 0:
		sliding_particles.emitting = true
	else:
		sliding_particles.emitting = false
	
	#particulas de correr
	if is_on_floor():
		if x_dir:
			run_particles.emitting = true
			if x_dir == 1:
				run_particles.transform.x.x = -1
			else:
				run_particles.transform.x.x = 1
			
		else:
			run_particles.emitting = false
	else :
		run_particles.emitting = false

func _physics_process(delta: float) -> void:
	
	#Gestiona los inputs, si queremos saltar en este frame o movernos a los lados
	inputs()
	
	#Gestiona las varibles como el coyote time los saltos restantes etc
	on_floor_and_walls_variables_manage(delta)
	
	#la gravedad
	gravity_manage(delta)
	
	#el salto y las condiciones de salto
	jump(delta)
	#wall_jump()
	
	#moverse
	move(delta)
	
	#gestiona la direccion que este mirando el pj
	dir()
	
	#gestiona las animaciones
	animations()
	
	#gestiona las particulas que no son del dash ni del salto
	particles()
