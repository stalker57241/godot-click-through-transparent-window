extends Node2D

var window: Window
var viewport: Viewport

enum {
	CALC_AXIS_Y
}

func _ready():
	window = get_tree().root
	viewport = window.get_viewport()
	window.transparent_bg = true
	viewport.transparent_bg = true

#func _process(_delta: float) -> void:
#	self.queue_redraw()

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit(0)
