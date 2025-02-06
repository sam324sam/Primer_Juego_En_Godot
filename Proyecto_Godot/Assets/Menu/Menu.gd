extends Control

var escena = preload("res://Escenas/Nivel 1/Nivel1.tscn")
var planeta
var viewport_rect
func _ready():
	viewport_rect = get_viewport_rect()
	planeta = [
		load("res://Escenas/Planeta1.tscn"),
		load("res://Escenas/Planeta2.tscn"),
		load("res://Escenas/Planeta3.tscn"),
		load("res://Escenas/Planeta4.tscn")
	]
	await get_tree().create_timer(0.1).timeout
	generarPlanetas()
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear_to_db(5))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Musica"), linear_to_db(2))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Efectos"), linear_to_db(1))

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

func _on_jugar_pressed():
	get_tree().change_scene_to_packed(escena)
	$AudioStreamPlayer2D.stop()

func _on_salir_pressed():
	get_tree().quit()

func _on_opciones_pressed():
	$Botones.hide()
	$Opciones.show()
	$Volver.show()
	
func _on_volver_pressed():
	$Botones.show()
	$Volver.hide()
	$Opciones.hide()
	
