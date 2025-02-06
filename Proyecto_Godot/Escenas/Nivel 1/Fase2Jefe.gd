extends Node2D
var poderes
var viewport_rect
# Called when the node enters the scene tree for the first time.
func _ready():
	Global.escenario = "/root/EscenarioFase2"
	$Ui/vidaJefe.visible = 1
	var musica = load("res://Assets/Jefe1/JefeFase2.mp3")
	$AudioStreamPlayer2D.stream = musica
	$AudioStreamPlayer2D.play()
	viewport_rect = get_viewport_rect()
	poderes = [
		load("res://Escenas/PorVelocidad.tscn"),
		load("res://Escenas/HeavyMachingun.tscn")
	]
	await get_tree().create_timer(2).timeout
	generar_PowerUp()
	generar_enemigo2()

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
				nr = 1
			elif  nr == 3:
				nr = 1
			var auxiliar = poderes[nr].instantiate()
			var min_x = viewport_rect.position.x
			var max_x = viewport_rect.size.x
			var random_x = randf_range(min_x + 400, max_x - 200)
			var min_y = viewport_rect.position.y
			var max_y = viewport_rect.size.y
			var random_y = randf_range(min_y + 400, max_y - 200)
			auxiliar.position.x = random_x
			auxiliar.position.y = random_y
			add_child(auxiliar)
			intervalo_power_up = false
			await get_tree().create_timer(20).timeout
			intervalo_power_up = true

var intervalo_enemigo2 = true
func generar_enemigo2():
	while true:
		if intervalo_enemigo2:
			var advertencia = load("res://Escenas/Advertencia.tscn").instantiate()
			var enemigo2 = load("res://Escenas/Enemigos/Enemigo2.tscn").instantiate()
			var min_x = viewport_rect.position.x
			var max_x = viewport_rect.size.x
			var random_x = randf_range(min_x + 400, max_x - 200)
			var min_y = viewport_rect.position.y
			var max_y = viewport_rect.size.y
			var random_y = randf_range(min_y + 400, max_y - 200)
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


func _on_audio_stream_player_2d_finished():
	$AudioStreamPlayer2D.play()

func cambiarEscena(escena):
	get_tree().change_scene_to_packed(escena)
