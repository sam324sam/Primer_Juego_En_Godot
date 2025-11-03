extends Node2D

var exploto = false
var gravedad = 5
func _physics_process(_delta):
	caida()

func _ready():
	await get_tree().create_timer(25).timeout
	queue_free()

func caida():
	position.y += gravedad

func _on_area_2d_area_entered(area):
	if !exploto:
		if area.is_in_group("bala"):
			gravedad = 0
			exploto = true
			$AnimationPlayer.play("Desaparecer")
			await get_tree().create_timer(0.01).timeout
			var areaEliminar = get_node("Area2D")
			if areaEliminar:
				areaEliminar.queue_free()
			await get_tree().create_timer(1.2).timeout
			queue_free()
		elif area.is_in_group("jugador"):
			Global.dañoAlJugador = 9
			gravedad = 0
			exploto = true
			$AnimationPlayer.play("Desaparecer")
			await get_tree().create_timer(0.01).timeout
			var areaEliminar = get_node("Area2D")
			if areaEliminar:
				areaEliminar.queue_free()
			await get_tree().create_timer(1.2).timeout
			queue_free()
		elif area.is_in_group("jefe"):
			gravedad = 0
			exploto = true
			$AnimationPlayer.play("Desaparecer")
			await get_tree().create_timer(0.01).timeout
			var areaEliminar = get_node("Area2D")
			if areaEliminar:
				areaEliminar.queue_free()
			await get_tree().create_timer(1.2).timeout
			queue_free()
