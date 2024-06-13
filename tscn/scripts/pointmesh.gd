extends Polygon2D
class_name MypointClass
var is_real = true:
	set(v):
		is_real = v
		if is_node_ready():
			if is_real:
				color = Color.CYAN
			else :
				color = Color.GREEN
				color.a = 0.7
var point_index: int
var father_node
var start_pos = Vector2.ZERO
@onready var mouse_in = false

func _ready() -> void:
	start_pos = global_position
	
	
func _process(delta: float) -> void:
	set_highlight()
	
func set_highlight():
	if Glo.picked_polys.has(self):
		set_color(Color.AQUAMARINE)
	else :
		set_color(Color.NAVAJO_WHITE)
	
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and mouse_in:
		if event.button_index == 1:
			if is_real:
				if Glo.picked_polys.has(self):
					pass
				else :
					Glo.picked_polys.append(self)
				Glo.point_index = point_index
			elif is_real != true and event.double_click:
				if Glo.picked_polys.has(self):
					pass
				else :
					Glo.picked_polys.append(self)
				var p_point = father_node.polygon
				p_point.insert(point_index + 1,position)
				father_node.polygon = p_point
				father_node.refresh()
		elif event.button_index == 2:
			if is_real and event.double_click:
				var p_point = father_node.polygon
				p_point.remove_at(point_index)
				father_node.polygon = p_point
				father_node.refresh()
			else :
				
				pass

func _on_area_2d_mouse_entered() -> void:
	mouse_in = true


func _on_area_2d_mouse_exited() -> void:
	mouse_in = false
