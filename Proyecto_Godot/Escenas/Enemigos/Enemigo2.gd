extends Node2D
var muelto = false
var tiempoDeReaccion = false
var vida = 100
var armadura = 0.5

func _ready(): 
	await get_tree().create_timer(3).timeout
	disparar()
	tiempoDeReaccion = true
	#darVueltas()
			
func _on_change_scene():
	queue_free()

func _physics_process(delta):
	if tiempoDeReaccion:
		if !muelto:
				$Sprite2D.rotation = $Sprite2D.rotation + 1 * delta
		
func disparar():
		while true:
			await get_tree().create_timer(0.2).timeout
			var bala = load("res://Escenas/Enemigos/DisparoEnemigo2.tscn").instantiate()
			bala.position.y = position.y
			bala.position.x = position.x
			bala.rotation = $Sprite2D.rotation
			if !muelto:
				get_parent().add_child(bala)

func _on_area_2d_area_entered(area):
	if !muelto:
		if area.is_in_group("bala"):
			vida -= Global.daño * armadura
			$Vida.size.x -= Global.daño * armadura
			if vida <= 0:
				morir()
		if area.is_in_group("jefe"):
			morir()

func morir():
	muelto = true
	$Loop.play("RESET")
	$Loop.play("Desaparecer")
	await get_tree().create_timer(0.1).timeout #Sin esto no funciona no se por que 
	var areaEliminar = get_node("Area2D")
	if areaEliminar:
		areaEliminar.queue_free()
	await get_tree().create_timer(2.9).timeout
	queue_free()
