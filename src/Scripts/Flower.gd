extends Sprite


"""
	This is the overlay sprite that is named "Flower" for no particular reason.
"""


signal avoid_triggered


func _ready() -> void:
	initialize_connections()
		
		
func initialize_connections() -> void:
	# Initializes signal connections.
	var err: int = connect("avoid_triggered", get_parent(),
			"_on_Flower_avoid_triggered")
	if err:
		print("Could not connect signal 'avoid_triggered' of %s." % name)
	

func get_click_polygon() -> PoolVector2Array:
	# Creates and returns the click polygon depending on the sprite size.
	var ts: Vector2 = texture.get_size() / 2
	var cp: PoolVector2Array = [
		global_position + ts * Vector2(-1, -1), # Top left corner
		global_position + ts * Vector2(1, -1), # Top right corner
		global_position + ts * Vector2(1 , 1), # Bottom right corner
		global_position + ts * Vector2(-1 ,1) # Bottom left corner
	]
	return cp


func _on_Area_input_event(_viewport: Node, event: InputEvent,
		_shape_idx: int) -> void:
	# Triggered when left clicked, "LMB" event is created in Project ->
	# Project Settings -> Input Map.
	if event.is_action_pressed("LMB"):
		emit_signal("avoid_triggered")
