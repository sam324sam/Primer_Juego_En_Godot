extends Node2D
var vida = 1152
var armadura = 0.18
var muerto = false
var atacando = false
var escena = preload("res://Escenas/Fin.tscn")
signal vida_reducida
func _ready():
	await get_tree().create_timer(0.01).timeout
	var ruta_ui = Global.escenario+"/Ui"
	connect("vida_reducida", Callable(get_node(ruta_ui), "actualizar_vida_jefe"))
	await get_tree().create_timer(2).timeout
	while !muerto:
		await get_tree().create_timer(0.01).timeout
		if !atacando:
			var nr = randi() % 3
			if nr == 0:
				ataque1()
			else:
				ataque2()

func ataque1():
	atacando = true
	$AnimationPlayer.play("ataque1")
	await get_tree().create_timer(3.5).timeout
	$AnimationPlayer.play("RESET")
	$AnimationPlayer.play("ataque1")
	await get_tree().create_timer(3.5).timeout
	$AnimationPlayer.play("irse")
	var blasters = load("res://Escenas/Enemigos/FilasBlasterJefe1Fase2.tscn").instantiate()
	get_node("/root/EscenarioFase2").add_child(blasters)
	await get_tree().create_timer(17.5).timeout
	$AnimationPlayer.play("venirse")
	await get_tree().create_timer(1).timeout
	atacando = false
	
func ataque2():
	atacando = true
	$AnimationPlayer.play("ataque2")
	await get_tree().create_timer(5).timeout
	$AnimationPlayer.play("irse")
	var fila = load("res://Escenas/Enemigos/PinchosFilas.tscn").instantiate()
	get_node("/root/EscenarioFase2").add_child(fila)
	await get_tree().create_timer(13.2).timeout
	$AnimationPlayer.play("venirse")
	await get_tree().create_timer(1).timeout
	atacando = false

func _on_area_2d_area_entered(area):
	if area.is_in_group("bala"):
		vida -= Global.daño * armadura
		if vida <= 0:
			muerto = true
			Global.cambiarEscena = "res://Escenas/Menu.tscn"
			emit_signal("vida_reducida", Global.daño * armadura,vida,escena)
			await get_tree().create_timer(0.5).timeout
			$Sprite2D/Area2D/CollisionShape2D.scale.x = 200
			$Sprite2D/Area2D/CollisionShape2D.scale.y = 200
			await get_tree().create_timer(1.6).timeout
			queue_free()
		emit_signal("vida_reducida", Global.daño * armadura,vida,escena)
