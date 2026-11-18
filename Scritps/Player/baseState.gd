@abstract class_name baseState extends Node
@onready var player:CharacterBody2D = get_tree().get_first_node_in_group("player")
@onready var animator: AnimatedSprite2D = get_tree().get_first_node_in_group("animator")
var direction:float 
@abstract func OnEnter() -> void

func ExitState(stateIndex: int) -> void:
	animator.stop()
	get_parent().ChangeState(stateIndex)

func ApplyDirection(speed:float) ->void:
	direction = Input.get_axis("left", "right")
	if direction:
		player.velocity.x = direction * speed
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, speed)

func FaceDirection() ->void:
	if 	direction > 0:
		animator.flip_h = false
	elif direction < 0:
		animator.flip_h = true
