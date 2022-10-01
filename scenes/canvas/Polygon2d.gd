extends Polygon2D

var drag: bool = false
var screen_size: Rect2 = get_viewport_rect()

# var texture_rect: Rect2 = Rect2(0, 0, 64, 64)

func _ready():
	print(screen_size)
	screen_size = get_viewport_rect()
	print(screen_size)
#func _input(event):
#	if event is InputEventMouseButton:
#		if event.button_index == MOUSE_BUTTON_LEFT:
#			drag = event.pressed
#			print(drag)
#	elif event is InputEventMouseMotion and drag == true:
#			var d_pos: Vector2 = self.position
#
#
#			self.position = d_pos + event.relative
#			for poly_point in polygon:
#				if not screen_size.has_point(self.position + poly_point):
#					self.position = d_pos
#					break
