extends AnimatableBody3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var player = get_tree().get_first_node_in_group("player")
	if player:
		global_rotation.y = player.global_rotation.y
	
