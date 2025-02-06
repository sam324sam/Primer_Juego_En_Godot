extends Node2D

func _on_heavy_machingun_area_entered(area):
	if area.is_in_group("jugador"):
		$AnimationPlayer.play("Desaparecer")
		# Para eliminar el area 2d 
		await get_tree().create_timer(0.1).timeout
		var areaEliminar = get_node("HeavyMachingun")
		if areaEliminar:# Si existe el nodo que lo elimine
			areaEliminar.queue_free()
		await get_tree().create_timer(2).timeout
		queue_free()

func _ready():
	await get_tree().create_timer(20).timeout
	queue_free()
