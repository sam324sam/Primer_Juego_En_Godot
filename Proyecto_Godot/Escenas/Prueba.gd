extends Node2D

func _ready():
	Global.escenario = "/root/Prueba"

func cambiarEscena(escena):
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_packed(escena)
