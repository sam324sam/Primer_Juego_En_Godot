extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().create_timer(6.6).timeout
	$AnimationPlayer.play("entrar")
	await get_tree().create_timer(6.6).timeout
	queue_free()
