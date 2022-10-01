extends Node2D


var window: Window
var viewport: Viewport

enum {
	CALC_AXIS_Y
}

func _ready():
	window = get_tree().root
	viewport = window.get_viewport()


func _physics_process(_delta: float) -> void:
	#poly = [] as PackedVector2Array
	var offset1 = $CharacterBody2d/Polygon2d.global_position #- Vector2(32, 32)
	var offset2 = $CharacterBody2d/Polygon2d2.global_position #- Vector2(32, 32)
	
	var poly1 = $CharacterBody2d/Polygon2d.polygon
	var poly2 = $CharacterBody2d/Polygon2d2.polygon
	
	poly1 = Transform2D(0, offset1) * poly1
	poly2 = Transform2D(0, offset2) * poly2
	var poly = Geometry2D.merge_polygons(poly1, poly2)[0] as PackedVector2Array
	# print_debug(poly)
	DisplayServer.window_set_mouse_passthrough(poly)

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit(0)
#func _draw():
#	if window.can_draw():
#		draw_polygon(poly[0], [], [])
