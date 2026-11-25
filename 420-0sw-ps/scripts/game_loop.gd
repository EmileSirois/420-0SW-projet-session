class_name GameLoop
extends Node2D


@export var pondRect : Rect2

var pondInterractables : Array

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	CaptureManager.game_loop = self
	
	await get_tree().physics_frame
	pondInterractables = get_areas_in_rect(pondRect)
	
	await get_tree().process_frame
	CaptureManager.select_trees()

func get_areas_in_rect(rect: Rect2, mask := 0xFFFFFFFF) -> Array[Area2D]:
	var shape := RectangleShape2D.new()
	shape.size = rect.size

	var params := PhysicsShapeQueryParameters2D.new()
	params.shape = shape
	params.transform = Transform2D(0.0, rect.get_center())
	params.collide_with_areas = true
	params.collide_with_bodies = false   # on ne veut que les Area2D
	params.collision_mask = mask

	var space := get_world_2d().direct_space_state
	var result: Array[Area2D] = []
	for hit in space.intersect_shape(params, 256):
		var area := hit.collider as Area2D
		if area and not result.has(area):   # une area à plusieurs shapes apparaît plusieurs fois
			result.append(area)
	return result
