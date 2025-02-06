extends Node2D

var point_a = self.position
var line
var rastreo = false
var local_point_b
var direction
var laser

func _ready():
	laser = $Laser
	laser.default_color = Color.RED
	line = $Line2D
	line.width = 2
	line.default_color = Color.RED
	await get_tree().create_timer(2).timeout
	rastreo = true
	ataque()
	

func generarLaser():
	direction = (local_point_b - point_a).normalized()
	var screen_size = get_viewport_rect().size
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
	laser.visible = 1
	$AnimationPlayer.play("Laser")
	generar_area2d(point_a,extended_point)
	

func generar_area2d(point_a: Vector2, extended_point: Vector2):
	direction = (extended_point - point_a).normalized()
	var angulo = direction.angle()
	var distancia = point_a.distance_to(extended_point)
	$Area2D/CollisionShape2D.rotation = angulo #Genero el area para coincidir con la linea (ver vectores)
	$Area2D/CollisionShape2D.scale.x = distancia
	$Area2D/CollisionShape2D.scale.y = 1  # Mantiene la altura del CollisionShape2D constante

func _physics_process(delta):
	if rastreo:
		var global_point_b = Global.posicionJugador
		local_point_b = to_local(global_point_b)
		line.points = [point_a, local_point_b]
		$Apuntado.position = local_point_b
		direction = (local_point_b - point_a).normalized()
		$Blaster.rotation = direction.angle()

func _on_area_2d_area_entered(area):
	if area.is_in_group("jugador"):
		Global.dañoAlJugador = 40

func ataque():
	var contador = 0
	while contador <= 2:
		await get_tree().create_timer(0.1).timeout
		$Apuntado.visible = 1
		$AnimationPlayer.play("apuntadoi")
		await get_tree().create_timer(2).timeout
		rastreo = false
		await get_tree().create_timer(0.5).timeout
		laser.width = 40
		$Apuntado.visible = 0
		generarLaser()
		await get_tree().create_timer(2).timeout
		rastreo = true
		$Area2D/CollisionShape2D.scale.x = 1
		line.visible = 1
		laser.visible = 0
		contador += 1
	rastreo = false
	line.visible = 0
