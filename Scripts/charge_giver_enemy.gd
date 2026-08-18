extends Enemy
class_name ChargeGiverEnemy




func _on_body_entered(body: Node2D) -> void:
	if body.has_method("get_movement_input"):
		charge_bar.increment_value(enemy_charge, 1.0)
