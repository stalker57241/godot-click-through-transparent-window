extends Polygon2D

var drag: bool = false


func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			drag = event.pressed
	
	elif event is InputEventMouseMotion and drag == true:
		var d_pos: Vector2 = self.position
		
		self.position = d_pos + event.relative
