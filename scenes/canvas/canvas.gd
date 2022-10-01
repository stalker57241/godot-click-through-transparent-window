extends Node2D


var window: Window
var viewport: Viewport

var sys_menu: Rect2 = Rect2(
	Vector2(0, 1017),
	Vector2(1920, 63)
)

func _ready():
	window = get_tree().root
	viewport = window.get_viewport()

	window.transparent_bg = true


func _process(delta):
#	DisplayServer.window_set_mouse_passthrough([
#		Vector2i.ZERO,
#		Vector2i(32, 0),
#		Vector2i.ONE * 32,
#		Vector2i(0, 32)
#	])
	var poly = []
	for poly_point in $Polygon2d.polygon:
		poly.append(poly_point + $Polygon2d.position)
	
	DisplayServer.window_set_mouse_passthrough(
		poly
	)

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit(0)
