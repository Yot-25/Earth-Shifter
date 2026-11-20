extends Node2D

@onready var player: CharacterBody2D = $"../player"
@onready var right: Area2D = $right
@onready var left: Area2D = $left

@export var earth_block:PackedScene
@export var blockArray:Array
@export var spawnOffset:Vector2 = Vector2(25,25)

var rightCan:bool = true
var leftCan:bool = true
var spawnPosition:Vector2

func _process(delta: float) -> void:
	right.global_position = player.global_position
	left.global_position = player.global_position
	
func SpawnBlock(fliped:bool)->void:
	var validPos = CheckPosition(fliped)
	if validPos == false:
		return
	CheckBlockArray()
	var newBlock = earth_block.instantiate()
	newBlock.global_position = spawnPosition
	blockArray.append(newBlock)
	add_child(newBlock)
	
	var tween = get_tree().create_tween()
	tween.tween_property(newBlock, "position", newBlock.position + Vector2(0,-25), 1)
	

func CheckPosition(fliped:bool)->bool:
	if fliped == true:
		spawnPosition = player.global_position+Vector2(-spawnOffset.x,spawnOffset.y)
		if leftCan:
			return true
	elif fliped == false:
		spawnPosition = player.global_position+Vector2(spawnOffset.x,spawnOffset.y)
		if rightCan:
			return true
	return false
	
func CheckBlockArray()->void:
	if blockArray.size() >= 1:
		for block in blockArray:
			block.queue_free()
		blockArray.clear()	

func MoveBlock(playerPos: float)->void:
	for block in blockArray:
		if(block.playerInRange == true):
			var moveDirection:float = (block.global_position.x - playerPos)
			if(moveDirection > 0):
				moveDirection = 1
			else:
				moveDirection = -1
			var tween = get_tree().create_tween()
			tween.tween_property(block, "position", block.position + Vector2(55,0)*moveDirection, .3)

func DestroyBlock()->void:
	for block in blockArray:
		block.queue_free()
	blockArray.clear()	
	
func _on_right_body_entered(body: Node2D) -> void:
	if body.is_in_group("map"):
		rightCan = true

func _on_right_body_exited(body: Node2D) -> void:
	if body.is_in_group("map"):
		rightCan = false


func _on_left_body_entered(body: Node2D) -> void:
	if body.is_in_group("map"):
		leftCan = true

func _on_left_body_exited(body: Node2D) -> void:
	if body.is_in_group("map"):
		leftCan = false
