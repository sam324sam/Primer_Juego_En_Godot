extends Node2D
	
func _on_area_2d_area_entered(area):
	if area.is_in_group("jugador"):
		Global.daño = 100

func inciarExplotar():
	pass

func _on_visibility_changed():
	if self.visible:
		$AnimationPlayer.play("boom")
