extends Node2D

func _on_area_2d_area_entered(area):
	if area.is_in_group("jugador"):
		Global.dañoAlJugador = 40
