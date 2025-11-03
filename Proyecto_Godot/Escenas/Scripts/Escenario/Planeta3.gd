extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	#modulate.a8 = 100
	await get_tree().create_timer(30).timeout
	queue_free()

var caida = 1
func _physics_process(delta):
	position.y += caida+delta-delta
	aumentar()
	
func aumentar():
	if Input.is_action_just_pressed("arriba"):
		caida = 4
	elif Input.is_action_just_released("arriba"):
		caida = 1
