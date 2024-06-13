extends Polygon2D
const pointmesh = preload("res://tscn/pointmesh.tscn")
var father_node:Node2D
var real_points:Array[Polygon2D] = []
var start_pos = Vector2.ZERO

func _ready() -> void:
	refresh()
	Glo.refresh_poly.connect(refresh)
	start_pos = global_position
	
func refresh():
	add_real_point()
	add_unreal_points()
	set_point_color()

func set_point_color():
	for i in get_children():
		if i is MypointClass:
			i.is_real = i.is_real

func add_unreal_points():
	var unreal_points = []
	for i in real_points.size():
		var new_pos = Vector2.ZERO
		if i == real_points.size() - 1:
			new_pos = (real_points[i].position + real_points[0].position) / 2.0
		else :
			new_pos = (real_points[i].position + real_points[i + 1].position) / 2.0
		unreal_points.append(new_pos)
	
	for i in unreal_points.size():
		var p_point = pointmesh.instantiate()
		p_point.position = unreal_points[i]
		p_point.point_index = i
		p_point.father_node = self
		p_point.is_real = false
		add_child(p_point)
		real_points.append(p_point)
	
	
func add_real_point():
	real_points = []
	for i in self.get_children():
		if i is Polygon2D:
			i.queue_free()
	for i in polygon.size():
		var p_point = pointmesh.instantiate()
		p_point.position = polygon[i]
		p_point.point_index = i
		p_point.father_node = self
		p_point.is_real = true
		add_child(p_point)
		real_points.append(p_point)
