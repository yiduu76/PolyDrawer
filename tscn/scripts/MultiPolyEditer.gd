extends Node2D
const multiwork_poly = preload("res://tscn/multiwork_poly.tscn")
func _ready() -> void:
	Glo.load_btn_selected.connect(load_btn_selected)
	Glo.save_to_res.connect(save_to_res)


func save_to_res(path:String):
	if is_visible_in_tree():
		var p_res = PolyRes.new()
		var childs = get_children()
		if childs.size() <= 0:
			return
		for i in childs.size():
			if childs[i] is Polygon2D:
				p_res.polygons.append({})
				p_res.polygons[i]["position"] = (childs[i] as Polygon2D).position
				p_res.polygons[i]["rotation"] = (childs[i] as Polygon2D).rotation
				p_res.polygons[i]["polygon"] = (childs[i] as Polygon2D).polygon
		ResourceSaver.save(p_res,path)

func load_btn_selected(p_path:String):
	if is_visible_in_tree():
		var p_res:PolyRes = load(p_path)
		for j in p_res.polygons:
			var p_poly = multiwork_poly.instantiate()
			p_poly.position = j["position"]
			p_poly.rotation = j["rotation"]
			p_poly.polygon = j["polygon"]
			self.add_child(p_poly)
