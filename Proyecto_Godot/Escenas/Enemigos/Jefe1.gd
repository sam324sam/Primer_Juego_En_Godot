extends Node2D
var vida = 1152
var armadura = 0.1
var intervalo_laser = false
var auxiliar = true
var muerto = false
var atacando = false
var encursoAtK3 = false
var escena = preload("res://Escenas/Nivel 1/InicioFase2.tscn")
signal vida_reducida
func _ready():
	await get_tree().create_timer(0.01).timeout
	if !muerto:
		var ruta_ui = Global.escenario+"/Ui"
		connect("vida_reducida", Callable(get_node(ruta_ui), "actualizar_vida_jefe"))
		await get_tree().create_timer(4).timeout
		ataque()
	
func _physics_process(delta):
	if auxiliar and !muerto:
		position.y += 50*delta
		await get_tree().create_timer(7.5).timeout
		auxiliar = false

func ataque():
	while !muerto:
		await get_tree().create_timer(2.5).timeout
		if !atacando:
			var nr
			if encursoAtK3:
				nr = 0
			else:
				nr = randi() % 4
			if nr == 0:
				ataqueTereDirigido()
			elif nr == 1:
				ataque3()
			else:
				ataqueLaser()

func _on_area_2d_area_entered(area):  #Arreglar
	if area.is_in_group("bala") and !muerto:
		vida -= Global.daño * armadura
		if vida <= 0 and !muerto:
			muerto = true
			Global.cambiarEscena = "res://Escenas/Nivel 1/CambioDeFaseAnimacion.tscn"
			emit_signal("vida_reducida", Global.daño * armadura,vida,escena)
			await get_tree().create_timer(0.5).timeout
			$Area2D/CollisionShape2D.scale.x = 200
			$Area2D/CollisionShape2D.scale.y = 200
			await get_tree().create_timer(1).timeout
			queue_free()
		emit_signal("vida_reducida", Global.daño * armadura,vida,escena)

func ataqueLaser():
	await get_tree().create_timer(1).timeout
	var advertencia = load("res://Escenas/Enemigos/AdvertenciaLaserJefe.tscn").instantiate()
	advertencia.position = position
	get_parent().add_child(advertencia)
	await get_tree().create_timer(1).timeout
	advertencia.queue_free()
	var laser = load("res://Escenas/Enemigos/LaseJefe.tscn").instantiate()
	laser.position = position
	get_parent().add_child(laser)
	await get_tree().create_timer(1).timeout
	laser.queue_free()

func ataqueTereDirigido():
	var contador = 0
	atacando = true
	while contador <= 1:
		await get_tree().create_timer(3).timeout
		var advertencia = load("res://Escenas/Enemigos/DisparoDirigidoJefe.tscn").instantiate()
		advertencia.position.x = position.x
		advertencia.position.y = position.y+360
		get_parent().add_child(advertencia)
		contador += 1
	atacando = false

func ataque3():
	encursoAtK3 = true
	$AnimationPlayer.play("ataque3")
	await get_tree().create_timer(3.2).timeout
	$Area2D/CollisionShape2D2.disabled = 1
	$Area2D/CollisionShape2D3.disabled = 1
	var ata3 = load("res://Escenas/Enemigos/ataque3Jefe.tscn").instantiate()
	get_node(Global.escenario).add_child(ata3)
	await get_tree().create_timer(9.5).timeout
	$AnimationPlayer.play("regresoAtaque3")
	await get_tree().create_timer(3.2).timeout
	$Area2D/CollisionShape2D2.disabled = 1
	$Area2D/CollisionShape2D3.disabled = 1
	encursoAtK3 = false

func muelto():
	muerto = true
	$LoopFuego.play("Muerte")
