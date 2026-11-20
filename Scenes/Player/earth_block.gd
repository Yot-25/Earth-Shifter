extends AnimatableBody2D


var playerInRange:bool = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		playerInRange = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		playerInRange = false


func _on_ground_check_body_exited(body: Node2D) -> void:
	if body.is_in_group("map"):
		print("exitetddddd")
