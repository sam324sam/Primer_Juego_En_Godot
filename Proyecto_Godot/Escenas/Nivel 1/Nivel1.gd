extends Node2D

var intervalo_asteroide = true
var inicio = false
var spawnEnemigos = true
var planeta
var advertencia
var enemigo2
var asteroide
var viewport_rect
var poderes
func precargarRecursos():
	viewport_rect = get_viewport_rect()
	planeta = [
		load("res://Escenas/Planeta1.tscn"),
		load("res://Escenas/Planeta2.tscn"),
		load("res://Escenas/Planeta3.tscn"),
		load("res://Escenas/Planeta4.tscn")
	]
	poderes = [
		load("res://Escenas/PorVelocidad.tscn"),
		load("res://Escenas/HeavyMachingun.tscn")
	]
	var musica = load("res://Assets/Escenario/Nivel1.mp3")
	$AudioListener2D/AudioStreamPlayer2D.stream = musica
	$AudioListener2D/AudioStreamPlayer2D.play()
	
func _ready():
	precargarRecursos()
	Global.escenario = "/root/Nivel1"
	await get_tree().create_timer(0.1).timeout
	generarPlanetas()
	await get_tree().create_timer(4).timeout
	generar_enemigo2()
	generar_PowerUp()
	generar_asteroide()
	await get_tree().create_timer(1).timeout
	generarFilaEnemigos()
	await get_tree().create_timer(55).timeout
	jefeFondo()
	await get_tree().create_timer(100).timeout
	aparecerJefe()

func jefeFondo():
	var jefeAlFondo = load("res://Escenas/Enemigos/jefeFondo1.tscn").instantiate()
	jefeAlFondo.position.y = viewport_rect.size.y
	var min_x = viewport_rect.position.x
	var max_x = viewport_rect.size.x
	var random_x = randf_range(min_x, max_x)
	jefeAlFondo.position.x = random_x
	get_parent().add_child(jefeAlFondo)

var intervalo_enemigo2 = true
func generar_enemigo2():
	while true:
		advertencia = load("res://Escenas/Advertencia.tscn").instantiate()
		enemigo2 = load("res://Escenas/Enemigos/Enemigo2.tscn").instantiate()
		await get_tree().create_timer(5).timeout
		if intervalo_enemigo2:
			var min_x = viewport_rect.position.x
			var max_x = viewport_rect.size.x
			var random_x = randf_range(min_x + 200, max_x - 200)
			var min_y = viewport_rect.position.y
			var max_y = viewport_rect.size.y
			var random_y = randf_range(min_y + 200, max_y - 200)
			advertencia.position.x = random_x
			advertencia.position.y = random_y
			enemigo2.position.x = random_x
			enemigo2.position.y = random_y
			get_parent().add_child(advertencia)
			await get_tree().create_timer(3).timeout
			get_parent().add_child(enemigo2)
			intervalo_enemigo2 = false
			await get_tree().create_timer(10).timeout
			intervalo_enemigo2 = true

func generar_asteroide():
	while true:
		if intervalo_asteroide:
			asteroide = load("res://Escenas/asteroide.tscn").instantiate()
			var min_x = viewport_rect.position.x
			var max_x = viewport_rect.size.x
			var random_x = randf_range(min_x, max_x)
			asteroide.position.x = random_x
			asteroide.position.y = -40
			asteroide.rotation = randf_range(0, PI * 2)
			get_parent().add_child(asteroide)
			intervalo_asteroide = false
			await get_tree().create_timer(0.5).timeout #Tiempo de s pawn entre asteroides
			intervalo_asteroide = true
		
var intervalo_power_up = true
func generar_PowerUp():
	while true:
		if intervalo_power_up:
			var nr = randi() % 4
			if nr == 0:
				nr = 0
			elif  nr == 1:
				nr = 0
			elif  nr == 2:
				nr = 0
			elif  nr == 3:
				nr = 1
			var auxiliar = poderes[nr].instantiate()
			var min_x = viewport_rect.position.x
			var max_x = viewport_rect.size.x
			var random_x = randf_range(min_x + 200, max_x - 200)
			var min_y = viewport_rect.position.y
			var max_y = viewport_rect.size.y
			var random_y = randf_range(min_y + 200, max_y - 200)
			auxiliar.position.x = random_x
			auxiliar.position.y = random_y
			get_parent().add_child(auxiliar)
			intervalo_power_up = false
			await get_tree().create_timer(20).timeout
			intervalo_power_up = true

var intervalo_planeta = true
func generarPlanetas():
	while true:
		if intervalo_planeta:
			var nr = randi() % planeta.size()  # randi() devuelve un número entero aleatorio
			var auxiliar = planeta[nr].instantiate()
			var min_x = viewport_rect.position.x
			var max_x = viewport_rect.size.x
			var random_x = randf_range(min_x, max_x)
			auxiliar.position.x = random_x
			auxiliar.position.y = -300
			intervalo_planeta = false
			get_parent().add_child(auxiliar)
			print("Planeta")
			await get_tree().create_timer(40).timeout
			intervalo_planeta = true

var intervalo_enemigos = true
func generarFilaEnemigos():
	while spawnEnemigos:
		if intervalo_enemigos:
			var enemigo = load("res://Escenas/OrganizacionEnemigos/FilaEnemigos1.tscn").instantiate()
			var min_x = viewport_rect.position.x
			var max_x = viewport_rect.size.x
			var random_x = randf_range(min_x + 250, max_x - 250)
			enemigo.position.x = random_x
			get_parent().add_child(enemigo)
			intervalo_enemigos = false
			await get_tree().create_timer(20).timeout
			intervalo_enemigos = true

func aparecerJefe():
	var auxiliar = true
	var jefe = load("res://Escenas/Enemigos/Jefe1.tscn").instantiate()
	jefe.position = Vector2(viewport_rect.size.x/2+10,-400)
	var advertencia = preload("res://Escenas/Enemigos/adevertenciaJefe.tscn").instantiate()
	advertencia.position = Vector2(viewport_rect.size.x/2+10,50)
	get_parent().add_child(advertencia)
	spawnEnemigos = false
	await get_tree().create_timer(3).timeout
	get_parent().add_child(jefe)
	var musica = load("res://Assets/Jefe1/jefe1Loop.mp3")
	$AudioListener2D/AudioStreamPlayer2D.stream = musica
	$AudioListener2D/AudioStreamPlayer2D.play()
	$Ui/vidaJefe.visible = 1
	$Ui/nombreJefe.visible = 1
	$Ui/nombreJefe.text = "La mamalona"

var musicaSTOP = false
func cambiarEscena(escena):
	musicaSTOP = true
	get_tree().change_scene_to_packed(escena)

func _on_audio_stream_player_2d_finished():
	if !musicaSTOP:
		$AudioListener2D/AudioStreamPlayer2D.play()
