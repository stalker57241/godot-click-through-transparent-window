extends Node


"""
	This is a singleton that keeps certain data to keep other scripts clean.
"""


var overlay_positions: Dictionary = {}


func _ready() -> void:
	initialize_singleton()


func initialize_singleton() -> void:
	# Initializes singleton variables.
	configure_overlay_positions()


func configure_overlay_positions() -> void:
	# Creates and adds overlay position keys and values to the 
	# `overlay_positions` variable depending on the specified margin.
	var ss: Vector2 = OS.get_screen_size()
	var margin: Vector2 = ss / 8
	overlay_positions["TopLeft"] = margin
	overlay_positions["TopRight"] = Vector2(ss.x, 0) + margin * Vector2(-1, 1)
	overlay_positions["BottomRight"] = ss + margin * Vector2(-1, -1)
	overlay_positions["BottomLeft"] = Vector2(0, ss.y) + margin * Vector2(1, -1)
