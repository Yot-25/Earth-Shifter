extends Node3D

@onready var player: CharacterBody3D = $"../Player"

var earth_block = preload("res://Scenes/Player/Earth_Block.tscn")
var spawnedBlocks: Array


func AddBlock(rayPos: Vector3, rayNormal):
	var block = earth_block.instantiate()
	var newTransform = Transform3D()
	newTransform.origin = rayPos
	if rayNormal.y > 0.5:
		newTransform = newTransform.rotated_local(Vector3.UP, player.global_rotation.y)
		
	else:
		var wallAngle = atan2(rayNormal.x, rayNormal.z)
		newTransform = newTransform.rotated_local(Vector3.UP, wallAngle)
		newTransform = newTransform.rotated_local(Vector3.RIGHT, PI / 2.0)
	block.global_transform = newTransform
	add_child(block)


func _on_ability_place_block(rayPos: Vector3, rayNormal) -> void:
	print("Block spawned")
	AddBlock(rayPos, rayNormal)
	
