extends CharacterBody3D

@onready var camera_3d: Camera3D = $CameraPivot/Camera3D
@onready var left_hand: Area3D = $CameraPivot/Camera3D/LeftHand

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
var screenSize: Vector2
var currentCharge: float
var maxCharge: float = 2

enum attackState{NORMAL, HEAVY, NONE}
var currentAttackState
var attackCooldown:bool = false
var speedMultiplier:float = 2

@export var rotationSpeed: float = 20
@export var xRotationLimit: float = 60
@onready var character_body_3d: CharacterBody3D = $"."

func _ready() -> void:
	currentAttackState = attackState.NONE
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	screenSize = get_viewport().get_visible_rect().size

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotation_degrees.y -= event.relative.x / rotationSpeed
		camera_3d.rotation_degrees.x -= event.relative.y /rotationSpeed
		camera_3d.rotation_degrees.x = clamp(camera_3d.rotation_degrees.x, -xRotationLimit, xRotationLimit)
		
		

func _physics_process(delta: float) -> void:
	if(not attackCooldown):
		if Input.is_action_pressed("attack"):
			currentCharge += delta* speedMultiplier
		if Input.is_action_just_released("attack"):
			attackCooldown = true
			Attack(currentCharge)
			
			var tween = get_tree().create_tween()
			tween.tween_property(left_hand, "position", Vector3.FORWARD + left_hand.position, .2)
			await get_tree().create_timer(.3).timeout 
			var tween1 = get_tree().create_tween()
			tween1.tween_property(left_hand, "position", Vector3.BACK + left_hand.position, .2)
			await get_tree().create_timer(1).timeout
			currentCharge = 0
			attackCooldown = false
			currentAttackState = attackState.NONE
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
	
	
func Attack(chargeAmount:float) -> void:
	if chargeAmount > maxCharge:
		currentAttackState = attackState.HEAVY
	else:
		currentAttackState = attackState.NORMAL
	

func _on_left_hand_body_entered(body: Node3D) -> void:
	if body is AnimatableBody3D:
		if currentAttackState == attackState.HEAVY:
			body.Pushed()
		elif currentAttackState == attackState.NORMAL:
			body.Destroy()
		else:
			pass
