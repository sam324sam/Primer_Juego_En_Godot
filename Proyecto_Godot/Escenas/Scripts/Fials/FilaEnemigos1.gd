extends VBoxContainer

var velocidad_vertical = 200
var velocidad_horizontal = 100
var contador_vertical = 0
var contador_horizontal = 0
var cambiar_direccion = false

func _ready():
	pass

func _physics_process(delta):
	# Movimiento vertical controlado por contador para bajarlo del spawn
	if contador_vertical < 50:
		position.y += velocidad_vertical * delta
		contador_vertical += 1
	else:
		velocidad_vertical = 0

	# Movimiento horizontal alternando dirección
	position.x += velocidad_horizontal * delta
	contador_horizontal += 1

	if contador_horizontal >= 150: #Afecta el intervalo de derecha a izquierda
		cambiar_direccion = not cambiar_direccion
		velocidad_horizontal = -velocidad_horizontal
		contador_horizontal = 0
