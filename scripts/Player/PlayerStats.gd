extends Resource

#Clase para añadir estadisticas
class_name PlayerStats


#Extra
@export var gravity = 0
@export var limit_fall_speed = 0

#movimiento
@export var move_speed = 0
@export var acceleration = 0
@export var deceleration = 0
@export var vel_power = 0.0

#salto
@export var jump_force = 0
@export var max_jump_duration = 0.0
@export var max_jumps = 0
@export var max_coyote_time = 0.0

#wall jump
@export var wall_jump_y_force = 0
@export var wall_jump_x_force = 0

#slide
@export var max_time_before_sliding = 0.0
@export var slide_speed = 0

#dash variables
@export var dash_force = 0
@export var max_dash_coldown = 0.0
@export var max_dash_duration = 0.0
@export var max_dashes = 0

func reiniciar_stats():
	move_speed = 0
	acceleration = 0
	deceleration = 0
	vel_power = 0

	#salto
	jump_force = 0
	max_jump_duration = 0
	max_jumps = 0
	max_coyote_time = 0

	#wall jump
	wall_jump_y_force = 0
	wall_jump_x_force = 0

	#slide
	max_time_before_sliding = 0
	slide_speed = 0

	#dash variables
	dash_force = 0
	max_dash_coldown = 0
	max_dash_duration = 0
	max_dashes = 0
