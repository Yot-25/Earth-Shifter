extends  baseState

func OnEnter() -> void:
	print("launch state")
	animator.play("launch")
	await animator.animation_finished
	earthManager.MoveBlock(player.global_position.x)
	ExitState(0)
