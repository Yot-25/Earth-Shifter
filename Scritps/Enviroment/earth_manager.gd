extends Node2D

@onready var player: CharacterBody2D = $"../player"

@export var earth_block:PackedScene
@export var blockArray:Array
var spawnPosition:Vector2
@export var spawnOffset:Vector2 = Vector2(25,25)
func SpawnBlock(fliped:bool)->void:
	var newBlock = earth_block.instantiate()
	CheckPosition(fliped)
	newBlock.global_position = spawnPosition
	blockArray.append(newBlock)
	add_child(newBlock)
	
	var tween = get_tree().create_tween()
	tween.tween_property(newBlock, "position", newBlock.position + Vector2(0,-25), 1)
	

func CheckPosition(fliped:bool)->void:
	if fliped == true:
		spawnPosition = player.global_position-spawnOffset
	elif fliped == false:
		spawnPosition = player.global_position+spawnOffset
