extends baseState

func OnEnter() -> void:
	animator.play("walk")
	print("is walking")


const SPEED = 100.0

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("jump"):
		player.velocity.y = -250.0
		ExitState(2)
	
func _physics_process(delta: float) -> void:

	FaceDirection()	
	ApplyDirection(SPEED)
	if not player.is_on_floor():
		ExitState(2)
	if player.velocity.x == 0:
		ExitState(0)
		
	player.move_and_slide()
