extends Node2D

var point_a = self.position
var line
var rastreo = true
var local_point_b
var direction
var laser

func _ready():
	laser = $Laser
	laser.default_color = Color.RED
	line = $Line2D
	line.width = 2
	line.default_color = Color.RED
	await get_tree().create_timer(0.1).timeout
	$Apuntado.visible = 1
	$AnimationPlayer.play("apuntadoi")
	await get_tree().create_timer(2).timeout
	rastreo = false
	await get_tree().create_timer(0.5).timeout
	laser.width = 40
	$Apuntado.visible = 0
	$AudioStreamPlayer2D.stop
	generarLaser()
	await get_tree().create_timer(2.5).timeout
	queue_free()

func generarLaser():
	direction = (local_point_b - point_a).normalized()
		# Calcula el punto donde la línea se extiende hasta el borde de la pantalla
	var screen_size = get_viewport_rect().size
		# Dependiendo de la dirección, calcula el punto de intersección con los bordes
	var extended_point = point_a
	if abs(direction.x) > abs(direction.y):  # Si la dirección es más horizontal
		if direction.x > 0:
			extended_point = point_a + direction * (screen_size.x - point_a.x) #Derecha
		else:
			extended_point = point_a + (direction * -1) * (screen_size.x + point_a.x) * -1 #Izquierda
	else:  # Si la dirección es más vertical
		if direction.y > 0:
			extended_point = point_a + direction * (screen_size.y - point_a.y) #Abajo
		else:
			extended_point = point_a + direction * -point_a.y #Arriba
	line.visible = 0
	laser.points = [point_a, extended_point]
	$AnimationPlayer.play("Laser")
	generar_area2d(point_a,extended_point)
	

func generar_area2d(point_a: Vector2, extended_point: Vector2):
	# Calcula el ángulo de rotación de la línea
	direction = (extended_point - point_a).normalized()
	var angulo = direction.angle()
	# Calcula la distancia entre los puntos
	var distancia = point_a.distance_to(extended_point)
	# Ajusta la rotación y el tamaño del CollisionShape2D
	$Area2D/CollisionShape2D.rotation = angulo #Genero el area para coincidir con la linea (ver vectores)
	$Area2D/CollisionShape2D.scale.x = distancia
	$Area2D/CollisionShape2D.scale.y = 1  # Mantiene la altura del CollisionShape2D constante

func _physics_process(delta):
	if rastreo:
		var global_point_b = Global.posicionJugador
		local_point_b = to_local(global_point_b)
		line.points = [point_a, local_point_b]
		$Apuntado.position = local_point_b

func _on_area_2d_area_entered(area):
	if area.is_in_group("jugador"):
		Global.dañoAlJugador = 40
