extends Control
@export_enum("Single", "Multi") var type: String = "Single"
@onready var single_polys_path = "res://Save/single_poly"
@onready var multi_polys_path = "res://Save/multi_poly"
@onready var btn_container: GridContainer = $MarginContainer/ScrollContainer/BtnContainer
const LOAD_POLY_BTN = preload("res://tscn/load_poly_btn.tscn")

func _ready() -> void:
	Glo.reload_poly.connect(load_to_show)

func load_to_show():
	for i in btn_container.get_children():
		i.queue_free()
	var single_dirs = []
	var multi_dirs = []
	var p_dir_1 = DirAccess.get_files_at(single_polys_path)
	var p_dir_2 = DirAccess.get_files_at(multi_polys_path)
	for i in p_dir_1:
		single_dirs.append(single_polys_path + "/" + i) 
	for i in p_dir_2:
		multi_dirs.append(multi_polys_path + "/" + i) 
	
	match type:
		"Single":
			add_poly_btn(single_dirs)
		"Multi":
			add_poly_btn((single_dirs + multi_dirs))

func add_poly_btn(dir:Array):
	for i in dir:
		var instance = LOAD_POLY_BTN.instantiate()
		btn_container.add_child(instance)
		instance.res_path = i
		var p_res:PolyRes = load(i)
		for j in p_res.polygons:
			var p_poly = Polygon2D.new()
			instance.get_node("Marker2D").add_child(p_poly)
			p_poly.position = j["position"]
			p_poly.rotation = j["rotation"]
			p_poly.polygon = j["polygon"]
			var p_points_max = []
			for k in p_poly.polygon:
				p_points_max.append(abs(k.x))
				p_points_max.append(abs(k.y))
			var max = p_points_max.max()
			var p_scale = 32.0/max/2.0
			p_poly.scale = Vector2(p_scale,p_scale)
