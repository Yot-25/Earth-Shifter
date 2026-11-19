extends  baseState

func OnEnter() -> void:
	print("launch state")
	animator.play("launch")
	await animator.animation_finished
	ExitState(0)
