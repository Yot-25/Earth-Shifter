extends CharacterBody3D

@onready var camera_3d: Camera3D = $CameraPivot/Camera3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
var screenSize: Vector2
var currentCharge: float
var maxCharge: float = 2

@export var rotationSpeed: float = 20
@export var xRotationLimit: float = 85
@onready var character_body_3d: CharacterBody3D = $"."

var spawnPoint: Transform3D

func _ready() -> void:
	spawnPoint = global_transform
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	screenSize = get_viewport().get_visible_rect().size

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotation_degrees.y -= event.relative.x / rotationSpeed
		camera_3d.rotation_degrees.x -= event.relative.y /rotationSpeed
		camera_3d.rotation_degrees.x = clamp(camera_3d.rotation_degrees.x, -xRotationLimit, xRotationLimit)
		
		

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "up", "down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction: 
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

func ResetWorld()->void:
	transform = spawnPoint
	
	
