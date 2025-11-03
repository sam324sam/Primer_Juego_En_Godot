extends CharacterBody2D

@export var speed = 500
var escudoActivo = true
var vidaEscudo = 100

var animador = AnimatableBody2D

func get_input():#Ver el input seleccionado Importante ir a configuracion de proyecto y asignar los botones
	var input_direction = Input.get_vector("izquierda", "derecha", "arriba", "abajo")
	animador = $AnimationPlayer
	velocity = input_direction * speed
	#Arreglar las animaciones
	if !exploto: 
		var animacion_actual = ""
		var animacion_anterior = ""
		if Input.is_action_pressed("izquierda"):
			animacion_actual = "izquierda"
		elif Input.is_action_just_released("izquierda"):
			animacion_actual = "para_izquierda"
		elif Input.is_action_pressed("derecha"):
			animacion_actual = "derecha"
		elif Input.is_action_just_released("derecha"):
			animacion_actual = "para_derecha"
		elif Input.is_action_pressed("arriba"):
			animacion_actual = "arriba"
		elif Input.is_action_just_released("arriba"):
			animacion_actual = "para_arriba"
		if animacion_actual != "" and animacion_actual != animacion_anterior:
			animador.play(animacion_actual)
			animacion_anterior = animacion_actual


func _physics_process(_delta):
	Global.posicionJugador = self.position
	if !exploto:
		get_input()
		move_and_slide()
	#print(speed)
	if Input.is_action_pressed("disparar") and !exploto:
		disparar()

var intervalo_entre_bala = true
var dps = 0.3
func disparar():
	if intervalo_entre_bala and !exploto:
		var bala = load("res://Escenas/bala.tscn").instantiate()
		bala.position.x = self.position.x
		bala.position.y = self.position.y
		get_parent().add_child(bala)
		intervalo_entre_bala = false 
		await get_tree().create_timer(dps).timeout 
		intervalo_entre_bala = true

signal vida_reducida # Esto es para el control de vidas y emiti la señal
func _ready():
	await get_tree().create_timer(0.1).timeout
	var ruta_ui = Global.escenario
	connect("vida_reducida", Callable(get_node(ruta_ui+"/Ui"), "actualizar_vidas")) 
	#Conectar al metodo que quieras La ruta depende de la escena principal tomando por el script global

func recoger_power_up():
	speed += 100

var exploto = false
var seQuitaElPoder = true
@export var vidas: int = 3
func _on_area_2d_area_entered(area):
	if area.is_in_group("Power_up"):
		print("Lo recogio")
		if  area.name == "PorVelocidad":
			speed += 300
			await get_tree().create_timer(10).timeout
			speed -= 300
		elif area.name == "HeavyMachingun":
			dps = 0.15
			await get_tree().create_timer(10).timeout
			dps = 0.3
	elif area.is_in_group("enemigo") or area.is_in_group("balaEnemigo"):
		if !Global.inmortal and !exploto and !escudoActivo:
			$AnimationPlayer.play("Explotar")
			exploto = true
			Global.inmortal = true
			await get_tree().create_timer(2.5).timeout
			if vidas == 0:
				get_tree().change_scene_to_file("res://Assets/Menu/Menu.tscn") #Cambiar a una escena de reset Falla por algun motivo
			elif vidas > 0:
				exploto = false
				vidas -= 1
				emit_signal("vida_reducida", vidas)  # Emitir señal aquí AAAAAAAAA Que horror las señales
				position.y = 589
				position.x = 968
				escudoActivo = true
				vidaEscudo = 100
				$Escudo.visible = 1
				$VidaEscudo.size.x = 100
				$AnimationPlayer.play("RESET")
				await get_tree().create_timer(0.1).timeout
				$Inmortal.play("Inmortal")
				await get_tree().create_timer(5).timeout
				Global.inmortal = false
		elif !Global.inmortal:
			await get_tree().create_timer(0.01).timeout
			vidaEscudo -= Global.dañoAlJugador
			$VidaEscudo.size.x -=  Global.dañoAlJugador
			if vidaEscudo <= 0:
				escudoActivo = false
				$Escudo.visible = 0
				await get_tree().create_timer(5).timeout
				if !exploto:
					escudoActivo = true
					vidaEscudo = 100
					$Escudo.visible = 1
					$VidaEscudo.size.x = 100
