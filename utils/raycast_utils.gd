extends Node2D # I need a CanvasItem/Node2D to get the World2D instance so I will use it as auto-load to have a Node2D guaranteed in the tree

func _query_raycast(world2D: World2D, initial_position: Vector2, target_position: Vector2, collision_mask: int, colliders_to_omit: Array, collide_with_areas: bool, collide_with_bodies: bool ) -> Dictionary:
	var space = world2D.direct_space_state
	var query: PhysicsRayQueryParameters2D = PhysicsRayQueryParameters2D.create(initial_position, target_position, collision_mask, colliders_to_omit)
	query.set_collide_with_areas(collide_with_areas)
	query.set_collide_with_bodies(collide_with_bodies)
	
	return space.intersect_ray(query)

func raycast(initial_position: Vector2, target_position: Vector2, collision_mask: int, colliders_to_omit = []) -> Dictionary:
	return _query_raycast(_get_world(), initial_position, target_position, collision_mask, colliders_to_omit, true, true)

func raycast_for_areas_only(initial_position: Vector2, target_position: Vector2, collision_mask: int, colliders_to_omit = []) -> Dictionary:
	return _query_raycast(_get_world(), initial_position, target_position, collision_mask, colliders_to_omit, true, false)
	
func raycast_for_bodies_only(initial_position: Vector2, target_position: Vector2, collision_mask: int, colliders_to_omit = []) -> Dictionary:
	return _query_raycast(_get_world(), initial_position, target_position, collision_mask, colliders_to_omit, false, true)

func does_result_contain_collider(raycast_result: Dictionary) -> bool:
	return raycast_result != null and raycast_result.has('collider')

func _get_world() -> World2D:
	return self.get_world_2d() # Need to extend CanvasItem to be able to call this method
