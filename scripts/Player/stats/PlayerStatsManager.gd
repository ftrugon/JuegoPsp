extends Resource

class_name PlayerStatsManager

@export var baseStats:Atributos_constantes
@export var itemsStats:PlayerStats

#Extras

func get_gravity():
	return itemsStats.gravity + baseStats.gravity 

func get_limit_fall_speed():
	return itemsStats.limit_fall_speed + baseStats.limit_fall_speed

#Movimiento
func get_move_speed():
	return itemsStats.move_speed + baseStats.move_speed

func get_acceleration():
	return itemsStats.acceleration + baseStats.acceleration

func get_deceleration():
	return itemsStats.deceleration + baseStats.deceleration

func get_vel_power():
	return itemsStats.vel_power + baseStats.vel_power


#salto

func get_jump_force():
	return itemsStats.jump_force + baseStats.jump_force
 
func get_max_jump_duration(): 
	return itemsStats.max_jump_duration + baseStats.max_jump_duration 

func get_max_jumps(): 
	return itemsStats.max_jumps + baseStats.max_jumps
 
func get_max_coyote_time(): 
	return itemsStats.max_coyote_time + baseStats.max_coyote_time


#wall jump

func get_wall_jump_y_force(): 
	return itemsStats.wall_jump_y_force + baseStats.wall_jump_y_force 

func get_wall_jump_x_force(): 
	return itemsStats.wall_jump_x_force + baseStats.wall_jump_x_force

func get_max_last_time_on_wall():
	return itemsStats.max_last_time_on_wall + baseStats.max_last_time_on_wall

#slide
func get_max_time_before_sliding(): 
	return itemsStats.max_time_before_sliding + baseStats.max_time_before_sliding 
	
func get_slide_speed(): 
	return itemsStats.slide_speed + baseStats.slide_speed


#dash variables

func get_dash_force() -> int:
	return itemsStats.dash_force + baseStats.dash_force

func get_max_dash_coldown() -> float:
	return itemsStats.max_dash_coldown + baseStats.max_dash_coldown

func get_max_dash_duration() -> float:
	return itemsStats.max_dash_duration + baseStats.max_dash_duration

func get_max_dashes() -> int:
	return itemsStats.max_dashes + baseStats.max_dashes
