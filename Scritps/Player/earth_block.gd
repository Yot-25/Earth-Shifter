extends AnimatableBody3D

@onready var mesh_instance_3d: MeshInstance3D = $MeshInstance3D
@onready var collision_shape_3d: CollisionShape3D = $CollisionShape3D
enum state{RISE, SHIFT, REST}
var currentState
func _ready() -> void:
	currentState = state.RISE
	RiseUp()


func RiseUp() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(mesh_instance_3d, "position", Vector3.UP*0.5, 1.5)
	var tween2 = get_tree().create_tween()
	tween2.tween_property(collision_shape_3d, "position", Vector3.UP*0.5, 1.5)
	if tween.finished and tween2.finished:
		UpdateState(state.REST)
		
func UpdateState(newState) -> void:
	currentState = newState
	print(currentState)
	
func Destroy() -> void:
	print("destroyed")
	
func Pushed() -> void:
	print("pushed")
	
	
	
