extends Node2D


"""
	This is the main scene the app utilizes.
"""


export(float, 0, 1.2, 0.01) var avoid_duration: float

var sprite_position_id: String = "TopLeft"

onready var Fw: Sprite = $Flower
onready var Up: Tween = $Updater
	
	
func _ready() -> void:
	initialize_window()
	
	
func initialize_window() -> void:
	# Initializes the app window.
	# Do not forget to allow "Per Pixel Transparency" from project settings 
	# under Project -> Project Settings -> Display -> Window -> Per Pixel
	# Transparency menu, otherwise transparent background will not work.
	var ss: Vector2 = OS.get_screen_size()
	OS.set_window_size(ss - Vector2(1, 1))
	OS.set_window_position(Vector2(0, 0))
	OS.set_window_always_on_top(true)
	# If window size covers the whole screen, you'll get a black background. In
	# order to prevent that, the window size is set to `ss - Vector2(1, 1)`.
	OS.set_borderless_window(true)
	OS.set_window_per_pixel_transparency_enabled(true)
	# For better results, it is advised to enable the two settings above, from
	# the project settings instead of here.
	get_tree().get_root().set_transparent_background(true)
	Fw.global_position = GlobalStash.overlay_positions[sprite_position_id]
	update_click_polygon()
	
	
func update_click_polygon() -> void:
	# Updates the area which is clickable, meaning that the inputs do not pass
	# through the window outside the specified area.
	OS.set_window_mouse_passthrough(Fw.get_click_polygon())


func _on_Flower_avoid_triggered() -> void:
	# Triggered on `trigger_avoid` signal of the `Flower` scene. This controls
	# the next position the `Flower` is going to move to.
	var ids: Array = GlobalStash.overlay_positions.keys()
	var new_id: String = ids[(ids.find(sprite_position_id) + 1) % ids.size()]
	avoid_click(Fw, new_id)
	
	
func avoid_click(object: Object, id: String) -> void:
	# When the `Flower` is clicked, it moves to the next position it
	# is supposed to move.
	sprite_position_id = id
	Up.remove(Fw, "global_position")
	Up.interpolate_property(object, "global_position",
		object.global_position, GlobalStash.overlay_positions[id],
		avoid_duration, Tween.TRANS_SINE, Tween.EASE_OUT, 0)
	Up.start()
	

func _on_Updater_tween_started(object: Object, key: NodePath) -> void:
	# This is for debugging purposes.
	var msg: String = "Started -> {0}{1}".format({0: object.name, 1: key})
	print(msg)


func _on_Updater_tween_completed(object: Object, key: NodePath) -> void:
	# This is for debugging purposes.
	var msg: String = "Ended   -> {0}{1}".format({0: object.name, 1: key})
	print(msg)


func _on_Updater_tween_step(object: Object, _key: NodePath, _elapsed: float,
		_value: Object) -> void:
	# Updates the clickable area (polygon), which is the `Flower` area, on each
	# step of interpolation.
	if object == Fw:
		update_click_polygon()
