extends baseState


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
	
func OnEnter() -> void:
	print("Idle Entered")
	animator.play("idle")
