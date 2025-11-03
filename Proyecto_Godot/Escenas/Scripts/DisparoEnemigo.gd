extends Node2D

func _ready():
	await get_tree().create_timer(10).timeout #Es mejor que el timer para todo y el rendimiento
	queue_free()

func _physics_process(_delta):
	if !desaparecer:
		position.y += 10

var desaparecer = false
func _on_area_2d_area_entered(area):
	if area.is_in_group("jugador"):
		Global.dañoAlJugador = 13
		$AnimationPlayer.play("Desaparecer")
		desaparecer = true
		var areaAEliminar = $Area2D
		if areaAEliminar:
			areaAEliminar.queue_free()
		await get_tree().create_timer(0.5).timeout
		queue_free()
		
