extends Node2D

func _on_change_scene():
	# Ejemplo de cómo liberar nodos antes de cambiar de escena
	for child in get_children():
		child.queue_free()
