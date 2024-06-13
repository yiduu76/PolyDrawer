extends Polygon2D
@onready var pick_area_polygon_2d: CollisionPolygon2D = $PickArea/PickAreaPolygon2D
var mouse_in = false
var start_pos = Vector2.ZERO

func _ready() -> void:
	start_pos = global_position
	

func _process(delta: float) -> void:
	set_highlight()
	if pick_area_polygon_2d.polygon != polygon:
		pick_area_polygon_2d.polygon = polygon
	if mouse_in and Input.is_action_just_pressed("ui_duplicate"):
		dupicate_self()
	elif Glo.picked_polys.has(self) and Input.is_action_just_pressed("ui_delete"):
		delete_self()
	elif Glo.picked_polys.has(self) and Input.is_action_just_pressed("ui_mirro"):
		mirro_self()

func set_highlight():
	if Glo.picked_polys.has(self):
		set_color(Color.AQUAMARINE)
	else :
		set_color(Color.NAVAJO_WHITE)
	

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and mouse_in:
		if event.button_index == 1 and Glo.picked_polys.has(self):
			pass
		elif event.button_index == 1 and not Glo.picked_polys.has(self):
			Glo.picked_polys.append(self)

func _on_pick_area_mouse_entered() -> void:
	mouse_in = true

func _on_pick_area_mouse_exited() -> void:
	mouse_in = false

func scale_by_mouse(p_type:String):
	match p_type:
		"up":
			polygon = return_by_scale(1.05)
		"down":
			polygon = return_by_scale(0.95)

func delete_self():
	Glo.reset_picked_polys()
	queue_free()

func dupicate_self():
	var p_duplicate = duplicate()
	get_parent().add_child(p_duplicate)

func mirro_self():
	var p_duplicate = duplicate()
	var mirro_polygon = []
	for i in polygon:
		mirro_polygon.append(Vector2(-i.x,i.y))
	p_duplicate.polygon = mirro_polygon
	p_duplicate.position = Vector2(-position.x,position.y)
	get_parent().add_child(p_duplicate)
	Glo.reset_picked_polys()

func return_by_scale(p_scale:float):
	var p_polygon = []
	for i in polygon:
		p_polygon.append(i*p_scale)
	return p_polygon
