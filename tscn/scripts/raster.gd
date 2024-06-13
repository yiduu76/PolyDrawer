extends Node2D

func _ready() -> void:
	spawn_lines()
	pass
	
func spawn_lines():
	for i in 50:
		var p_line_v = Line2D.new()
		if i % 5 == 0:
			p_line_v.width = 0.7
			p_line_v.default_color = Color.html("ffffff21")
		else :
			p_line_v.width = 0.35
			p_line_v.default_color = Color.html("ffffff12")
			
		add_child(p_line_v)
		p_line_v.add_point(Vector2(0,i * 8))
		p_line_v.add_point(Vector2(320,i * 8))

		var p_line_h = Line2D.new()
		if i % 5 == 0:
			p_line_h.width = 0.7
			p_line_h.default_color = Color.html("ffffff21")
			
		else :
			p_line_h.width = 0.35
			p_line_h.default_color = Color.html("ffffff12")
			
		add_child(p_line_h)
		p_line_h.add_point(Vector2(i*8,0))
		p_line_h.add_point(Vector2(i*8,180))
