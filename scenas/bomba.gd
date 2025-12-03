extends Node2D

@export var duration: float
var pulsos: int = 0

func _ready() -> void:
	var numg = Vector2(int(global_position.x / 16), int(global_position.y / 16))
	global_position = Vector2(numg.x * 16 - 8, numg.y * 16)
	
	$RayCast2D.add_to_group('raycast')
	$RayCast2D2.add_to_group('raycast')
	$RayCast2D3.add_to_group('raycast')
	$RayCast2D4.add_to_group('raycast')
	
	var raycasts = get_tree().get_nodes_in_group('raycast')
	for r in raycasts:
		r.add_exception(get_tree().get_nodes_in_group('player_2')[0])

func _physics_process(delta):
	check_raycast();
	

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if (anim_name == 'explosion'):
		queue_free()
	elif (anim_name == 'idle'):
		pulsos += 1
		if (pulsos == 3):
			$AnimationPlayer.play('explosion')
			pulsos = 0
		else:
			$AnimationPlayer.play('idle')

func check_raycast():
	var raycasts = get_tree().get_nodes_in_group('raycast')
	for r in raycasts:
		if (r.is_colliding()):
			var col = r.get_collider()
			if (col != null && col.is_in_group('bloque')):
				var pc = r.get_collision_point()
				var tilemap = get_tree().get_nodes_in_group('tilemap')[0]
				pc = tilemap.local_to_map(pc)
				tilemap.set_cell(pc, -1)
				
				
				# col.queue_free()
