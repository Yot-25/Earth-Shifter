extends baseState

var airSpeed = 80
const JUMP_VELOCITY = -250
var hasJumped:bool = false
func OnEnter() -> void:
	JumpChange()
	
func _physics_process(delta: float) -> void:
	if player.velocity.y < 0:
		animator.play("jumpup")
	elif player.velocity.y > 0:
		animator.play("jumpdown")
		
	if not player.is_on_floor():
		player.velocity += player.get_gravity() * delta
	if player.is_on_floor() and hasJumped == true and direction:
		hasJumped = false
		ExitState(1)	
	FaceDirection()
	ApplyDirection(airSpeed)

	player.move_and_slide()

func JumpChange()-> void:
	await get_tree().create_timer(.1).timeout
	hasJumped = not hasJumped
	
	
	
