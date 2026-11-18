extends Node


@onready var animator: AnimatedSprite2D = $"../animator"
@onready var idle_state: Node = $idleState
@onready var walk_state: Node = $walkState
@onready var place_state: Node = $placeState
@onready var jump_state: Node = $jumpState
@onready var launch_state: Node = $launchState
var stateDictionary: Dictionary[STATES, Node]
var disableNode: int = 4
var enableNode: int = 0

enum STATES {IDLE, WALK, JUMP, LAUNCH, PLACE}
var currentState: STATES = STATES.IDLE

func _ready() -> void:
	stateDictionary = {
		STATES.IDLE: idle_state, 
		STATES.WALK: walk_state,
		STATES.JUMP: jump_state,
		STATES.PLACE: place_state,
		STATES.LAUNCH: launch_state
		}
	ChangeState(STATES.IDLE)


func ChangeState(newState:STATES) -> void:
	Disable()
	currentState = newState
	stateDictionary.get(newState).OnEnter()
	Enable()
	
func Disable() ->void:
	stateDictionary.get(currentState).process_mode = disableNode
	
func Enable() ->void:
	stateDictionary.get(currentState).process_mode = enableNode	
	
	
