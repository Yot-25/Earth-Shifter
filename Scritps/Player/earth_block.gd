extends AnimatableBody3D

@onready var mesh_instance_3d: MeshInstance3D = $MeshInstance3D
@onready var collision_shape_3d: CollisionShape3D = $CollisionShape3D
@onready var area_3d: Area3D = $Area3D

var riseMult: float = 1.5
var duration:float = .3

func _ready() -> void:
	RiseUp()


func RiseUp() -> void:
	var tween = create_tween().set_parallel(true)
	tween.tween_property(mesh_instance_3d, "position", Vector3.UP*riseMult, duration).as_relative()
	tween.tween_property(collision_shape_3d, "position", Vector3.UP*riseMult, duration).as_relative()
	tween.tween_property(area_3d, "position", Vector3.UP*riseMult, duration).as_relative()

	
	
	
