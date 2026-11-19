extends baseState



func OnEnter() -> void:
	print("place state")
	earthManager.SpawnBlock(animator.flip_h)
	animator.play("place")
	await get_tree().create_timer(.3).timeout
	ExitState(0)
