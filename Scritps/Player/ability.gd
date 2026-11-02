extends Node3D

@onready var ability_holder: Node3D = $"../../AbilityHolder"
@onready var ray_cast_3d: RayCast3D = $"../CameraPivot/Camera3D/RayCast3D"
@export var earthblock: PackedScene
@onready var preview_block: Node3D = $PreviewBlock
signal placeBlock(rayPos:Vector3, rayNormal: Vector3)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	preview_block.visible = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("place"):
		placeBlock.emit(ray_cast_3d.get_collision_point(), ray_cast_3d.get_collision_normal())
		
func _physics_process(delta: float) -> void:
	if ray_cast_3d.is_colliding():
		previewObject()
	else:
		preview_block.visible = false


func previewObject():
	preview_block.global_position = ray_cast_3d.get_collision_point()
	preview_block.visible = true
	
