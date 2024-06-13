extends Control
@onready var single_poly_name_edit: LineEdit = $SinglePolyEditer/HBoxContainer/SinglePolyNameEdit
@onready var single_poly_editer: Control = $SinglePolyEditer
@onready var multi_poly_editer: Control = $MultiPolyEditer
@onready var multi_poly_name_edit: LineEdit = $MultiPolyEditer/HBoxContainer/MultiPolyNameEdit

func _on_save_single_ploy_button_up() -> void:
	var p_name = single_poly_name_edit.text
	if p_name.length()>0:
		var path = "res://Save/single_poly/%s.res" % [p_name]
		Glo.save_to_res.emit(path)

func _on_save_multi_ploy_button_up() -> void:
	var p_name = multi_poly_name_edit.text
	if p_name.length()>0:
		var path = "res://Save/multi_poly/%s.res" % [p_name]
		Glo.save_to_res.emit(path)


func _on_single_btn_button_up() -> void:
	single_poly_editer.show()
	multi_poly_editer.hide()


func _on_multi_btn_button_up() -> void:
	single_poly_editer.hide()
	multi_poly_editer.show()


func _on_single_poly_editer_visibility_changed() -> void:
	if single_poly_editer:
		if single_poly_editer.is_visible_in_tree():
			Glo.reset_picked_polys()
			Glo.current_edit_type = "single"
			Glo.reload_poly.emit()


func _on_multi_poly_editer_visibility_changed() -> void:
	if multi_poly_editer:
		if multi_poly_editer.is_visible_in_tree():
			Glo.reset_picked_polys()
			Glo.current_edit_type = "multi"
			Glo.reload_poly.emit()
