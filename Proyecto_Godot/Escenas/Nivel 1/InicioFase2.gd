extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	await  get_tree().create_timer(1).timeout
	$Sprite2D/muerte.play("muerto")
	var musica = load("res://Assets/Jefe1/cambioDefase2.mp3")
	$AudioStreamPlayer2D.stream = musica
	$AudioStreamPlayer2D.play()
	await  get_tree().create_timer(7).timeout
	$CambioDeEscema/AnimationPlayer.play("FundidoNegro")
	await  get_tree().create_timer(1).timeout
	Global.escenario = "/root/EscenarioFase2"
	var escena = load("res://Escenas/Nivel 1/Fase2Jefe.tscn")
	get_tree().change_scene_to_packed(escena)
