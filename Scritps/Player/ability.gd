extends Node3D

@onready var ability_holder: Node3D = $"../../AbilityHolder"
@onready var ray_cast_3d: RayCast3D = $"../CameraPivot/Camera3D/RayCast3D"
@export var earthblock: PackedScene
signal placeBlock(rayPos:Vector3, rayNormal: Vector3)
var isOnCooldown: bool = false


func _input(event: InputEvent) -> void:
	if isOnCooldown ==false:
		if event.is_action_pressed("place"):
			isOnCooldown = true
			placeBlock.emit(ray_cast_3d.get_collision_point(),
			 ray_cast_3d.get_collision_normal())
			await get_tree().create_timer(2).timeout 
			isOnCooldown = false
		
