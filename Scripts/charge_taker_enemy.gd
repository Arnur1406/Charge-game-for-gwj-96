extends Enemy
class_name ChargeTakerEnemy


func _on_body_entered(body: Node2D) -> void:
	super(body)
	if body.has_method("get_movement_input") and not is_stunned:
		charge_bar.increment_value(enemy_charge, 0.0)
