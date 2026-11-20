extends baseState

func OnEnter() -> void:
	print("Idle Entered")
	animator.play("idle")

func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("left") or Input.is_action_pressed("right"):
		ExitState(1)
	elif event.is_action_pressed("jump"):
		player.velocity.y = -250.0
		ExitState(2)
	elif event.is_action_pressed("place"):
		ExitState(4)
	elif event.is_action_pressed("launch"):
		ExitState(3)

func _physics_process(delta: float) -> void:
	if not player.is_on_floor():
		ExitState(2)
	player.move_and_slide()
