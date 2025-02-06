extends Node2D
var muelto = false
var vida = 100
var armadura = 1
var exploto = false

func _ready(): 
	await get_tree().create_timer(1).timeout
	disparar()
	
func disparar():
		while true:
			await get_tree().create_timer(2).timeout
			if !muelto:
				$AnimationPlayer.play("Disparar")
				$Disparo.play()
			await get_tree().create_timer(2.3).timeout
			var bala = load("res://Escenas/Enemigos/DisparoEnemigo.tscn").instantiate() #Para generar la bala
			bala.position.y = position.y  # Posición global del personaje
			bala.position.x = position.x
			if !muelto:
				get_parent().add_child(bala)

func _on_area_2d_area_entered(area):
	if area:
		if area.is_in_group("bala") and !muelto:
			vida -= Global.daño * armadura
			$Vida.size.x -= Global.daño * armadura
			if vida <= 0:
				morir()
		if area.is_in_group("jefe") and !muelto:
			morir()

func morir():
	muelto = true
	$AnimationPlayer.play("RESET")
	$Loop_y_desparecer.play("RESET")
	$Loop_y_desparecer.play("Desaparecer")
	await get_tree().create_timer(0.1).timeout #Sin esto no funciona no se por que 
	$Disparo.stop()
	#await get_tree().create_timer(0.1).timeout
	var areaEliminar = get_node("Area2D")
	if areaEliminar:
		areaEliminar.queue_free()
	await get_tree().create_timer(3.6).timeout
	queue_free()
