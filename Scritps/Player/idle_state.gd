extends baseState

@onready var animator: AnimatedSprite2D = $"../../animator"

func _input(event: InputEvent) -> void:
	pass
	
func OnEnter() -> void:
	print("Idle Entered")
	animator.play("idle")
	
func OnExit() -> void:
	pass
