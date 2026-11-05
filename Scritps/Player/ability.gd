extends Node3D

@onready var ability_holder: Node3D = $"../../AbilityHolder"
@onready var ray_cast_3d: RayCast3D = $"../CameraPivot/Camera3D/RayCast3D"
signal placeBlock(rayPos:Vector3, rayNormal: Vector3)
var isActing:bool = false


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("place") and not isActing:
		isActing = true
		if(ray_cast_3d.is_colliding()):
			var collider = ray_cast_3d.get_collider()
			if collider is Area3D and collider.is_in_group("Block"):
				print("checked")
				isActing = false
				return
			var point = ray_cast_3d.get_collision_point()
			var normal = ray_cast_3d.get_collision_normal()
			
			if not EdgeDetection(point, normal):
				print("edge is close")
				isActing = false
				return
		
			placeBlock.emit(point,normal)
			await get_tree().create_timer(1).timeout 
			isActing = false
		else:
			isActing = false
			
			

func EdgeDetection(center_pos: Vector3, normal: Vector3)-> bool:
	var space_state = get_world_3d().direct_space_state
	var block_size = 0.45
	var up_ref = Vector3.UP
	if abs(normal.dot(up_ref)) > 0.99:
		up_ref = Vector3.FORWARD
		
	var tangent = normal.cross(up_ref).normalized()
	var bitangent = normal.cross(tangent).normalized()
	var offsets = [
		tangent * block_size,
		-tangent * block_size,
		bitangent * block_size,
		-bitangent * block_size
	]
	
	for offset in offsets:
		var check_pos = center_pos + offset
		var ray_query = PhysicsRayQueryParameters3D.create(
			check_pos + (normal * 0.2), 
			check_pos - (normal * 0.5)
		)
		var result = space_state.intersect_ray(ray_query)
		if result.is_empty():
			return false
	return true
