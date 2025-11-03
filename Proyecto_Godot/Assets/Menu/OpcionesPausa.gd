extends Control
var resolucion_actual
var sonido
var resoluciones = ["1920x1080", "1280x720", "800x600"]

func _on_option_button_item_selected(index):
	resolucion_actual = index
	var resolucion = resoluciones[index].split("x")
	var ancho = int(resolucion[0])
	var alto = int(resolucion[1])
	# Cambia la resolución usando DisplayServer
	DisplayServer.window_set_size(Vector2i(ancho, alto))
	# Opcional: ajusta el tamaño del Viewport para asegurarte de que la interfaz se ajuste a la nueva resolución
	get_viewport().size = Vector2(ancho, alto)
	print("Resolución cambiada a: ", resoluciones[index])
	if DisplayServer.window_get_mode() != DisplayServer.WindowMode.WINDOW_MODE_FULLSCREEN: #Esto es para que al cambiar se ajuste
		DisplayServer.window_set_mode(DisplayServer.WindowMode.WINDOW_MODE_WINDOWED)
	else:
		DisplayServer.window_set_mode(DisplayServer.WindowMode.WINDOW_MODE_FULLSCREEN)

func _on_master_value_changed(value):
	var volumen = value
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear_to_db(volumen))

func _on_musica_value_changed(value):
	var volumen = value
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Musica"), linear_to_db(volumen))

func _on_efectos_value_changed(value):
	var volumen = value
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Efectos"), linear_to_db(volumen))

func _on_check_button_toggled(_toggled_on):
	if DisplayServer.window_get_mode() == DisplayServer.WindowMode.WINDOW_MODE_FULLSCREEN:
		DisplayServer.window_set_mode(DisplayServer.WindowMode.WINDOW_MODE_WINDOWED)
	else:
		DisplayServer.window_set_mode(DisplayServer.WindowMode.WINDOW_MODE_FULLSCREEN)
