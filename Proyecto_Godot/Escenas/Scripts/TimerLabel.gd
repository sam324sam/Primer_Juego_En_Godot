extends Label

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	actualizar_tiempo(delta)

var tiempo_transcurrido = 0.0
func actualizar_tiempo(delta):
	tiempo_transcurrido += delta
	Global.tiempo = tiempo_transcurrido
	var minutos = int(tiempo_transcurrido / 60)
	var segundos = int(tiempo_transcurrido) % 60
	var tiempo_formateado = str(minutos) + ":" + formatear_segundos(segundos)
	text = tiempo_formateado

func formatear_segundos(segundos):
	if segundos < 10:
		return "0" + str(segundos)
	return str(segundos)
