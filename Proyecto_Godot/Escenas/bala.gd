extends Node2D
var daño = 50
var velocidad = 10
var inpacto = false

func  _physics_process(delta):
	position.y -= velocidad
	
func _ready():
	await get_tree().create_timer(10).timeout
	queue_free()

func _on_area_2d_area_entered(area):
	if area.is_in_group("enemigo") and !inpacto:
		velocidad = 0
		inpacto = true
		$AnimationPlayer.play("Inpacto")
		var areaDeBala = get_node("Area2D")
		if areaDeBala:
			areaDeBala.queue_free()
		await get_tree().create_timer(0.5).timeout
		queue_free()
