extends Control

signal cambioEscena
func _ready():
	await get_tree().create_timer(0.1).timeout
	var ruta = Global.escenario
	connect("cambioEscena", Callable(get_node(ruta), "cambiarEscena"))
	if not DisplayServer.is_touchscreen_available() and Global.android:
		$Disparar.hide()

func actualizar_vidas(vidas):
	print("Funciona la conexion")
	print("Vidas restantes: ", vidas)
	# Actualizar la interfaz de usuario con las vidas restantes
	if vidas == 2:
		$Vidas/TextureRect3.hide()
	elif vidas == 1:
		$Vidas/TextureRect2.hide()
	elif vidas == 0:
		$Vidas/TextureRect.hide()

func actualizar_vida_jefe(daño,vida, escena):
	$vidaJefe.size.x -= daño
	if vida <= 0:
		await get_tree().create_timer(0.6).timeout
		fundidoNegro(escena)

func fundidoNegro(escena):
	$CambioDeEscema/AnimationPlayer.play("FundidoNegro")
	Global.inmortal = true
	await get_tree().create_timer(1).timeout
	emit_signal("cambioEscena",escena)
	Global.inmortal = false

func _on_disparar_pressed():
	Input.action_release("disparar")
