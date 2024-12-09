extends Area2D


@onready var timer = $Timer


@export var where_to_tp = Vector2(1145,313)

var tp_to_spawn = false
var body_var = Node2D

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body_var = body
		body.die()
		Engine.time_scale = 0.5
		timer.start()

func _on_timer_timeout() -> void:
	Engine.time_scale = 1
	tp_to_spawn = true

func _process(delta: float) -> void:
	if tp_to_spawn and body_var is Player:
			body_var.position = where_to_tp
			tp_to_spawn = false
			
