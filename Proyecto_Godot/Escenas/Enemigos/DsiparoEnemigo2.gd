extends Node2D

func _ready():
	await get_tree().create_timer(10).timeout #Es mejor que el timer para todo y el rendimiento
	queue_free()
	
var desaparecer = false
func _physics_process(delta):
	# Mover la bala en la dirección de su rotación
	if !desaparecer:
		var direction = Vector2(cos(rotation), sin(rotation))
		position += direction * 700 * delta

func _on_area_2d_area_entered(area):
	if area.is_in_group("jugador"):
		Global.dañoAlJugador = 20
		$Sprite2D/AnimationPlayer.play("desaparecer")
		desaparecer = true
		var areaAEliminar = $Area2D
		if areaAEliminar:
			areaAEliminar.queue_free()
		await get_tree().create_timer(0.5).timeout
		queue_free()
