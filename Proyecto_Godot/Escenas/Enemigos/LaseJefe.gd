extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

var ticks = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if ticks:
		$Area2D.hide()


func _on_area_2d_area_entered(area):
	if area.is_in_group("jugador"):
		Global.dañoAlJugador = 40
		ticks = false
		await get_tree().create_timer(0.2).timeout
		ticks = true
