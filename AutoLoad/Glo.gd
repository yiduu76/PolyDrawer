extends Node2D
var picked_polys:Array[Polygon2D] = []
var point_index:int
var current_edit_type = "single"
var in_multi_select_mode = false
var mouse_vec = Vector2.ZERO

signal refresh_poly
signal reload_poly
signal save_to_res
signal load_btn_selected

func reset_picked_polys():
	picked_polys = []

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		reset_picked_polys()
		refresh_poly.emit()
	if event is InputEventMouseMotion:
		mouse_vec = event.velocity / 100.0
		if mouse_vec.length_squared() <= 0.5:
			mouse_vec = Vector2.ZERO
		


func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_ctrl"):
		in_multi_select_mode = true
	else :
		in_multi_select_mode = false
	
	if in_multi_select_mode == false:
		if picked_polys.size() <= 1:
			move_one_poly()
		elif picked_polys.size() > 1:
			move_polys()


func move_polys():
	for i in picked_polys:
		i.global_position += mouse_vec
		pass
	pass

func move_one_poly():
	var target_pos = get_global_mouse_position()
	target_pos.x = int(target_pos.x)
	target_pos.y = int(target_pos.y)
	match current_edit_type:
		"single":
			for i in picked_polys:
				i.global_position = target_pos
				if i is MypointClass:
					if i.father_node != null:
						i.father_node.polygon[point_index] = i.position
		"multi":
			for i in picked_polys:
				i.global_position = target_pos
				if Input.is_action_just_pressed("ui_rotate_r"):
					i.rotation_degrees += 90
				elif Input.is_action_just_pressed("ui_rotate_l"):
					i.rotation_degrees -= 90
				elif Input.is_action_just_pressed("ui_scale_down"):
					i.scale_by_mouse("down")
				elif Input.is_action_just_pressed("ui_scale_up"):
					i.scale_by_mouse("up")
