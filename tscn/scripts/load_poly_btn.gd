extends Button
@export var res_path:String = ""


func _on_button_up() -> void:
	Glo.load_btn_selected.emit(res_path)
