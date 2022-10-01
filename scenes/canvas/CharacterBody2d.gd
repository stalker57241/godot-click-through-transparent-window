extends CharacterBody2D

var screen_size: Rect2 # = get_viewport_rect()


const SPEED = 300.0
const JUMP_VELOCITY = -800.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var holding: bool = false
# var polygon: PackedVector2Array = [] as PackedVector2Array

enum {
	STATE_IN_AIR = -1,
	STATE_ON_FLOOR = 0,
	STATE_ON_WALL = 1,
	STATE_ON_CEILING = 2,
	STATE_MAX,
}

var state: int = STATE_IN_AIR

func _ready():
	screen_size = get_viewport_rect()

func _physics_process(delta):
	# Add the gravity.
	if state != STATE_ON_FLOOR and not holding:
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_pressed("ui_accept") and state == STATE_ON_FLOOR:
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	# var direction = 0
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	# var p_position = self.position
	
	# print(p_position)
	state = -1
	for poly_point in $CollisionPolygon2d.polygon:
		var p_point = poly_point + $Polygon2d.position
		if p_point.y + self.position.y >= screen_size.end.y - 48:
			velocity.y = 0 if (
					self.position.y + velocity.y >= screen_size.end.y - 48
			) else velocity.y
			state = STATE_ON_FLOOR
		if p_point.y + self.position.y <= screen_size.position.y:
			velocity.y = 0 if (
					self.position.y + velocity.y <= screen_size.position.y
			) else velocity.y
			state = STATE_ON_CEILING
		if p_point.x + self.position.x >= screen_size.end.x:
			velocity.x = 0 if direction > 0 else velocity.x
			state = STATE_ON_WALL
		if p_point.x + self.position.x <= screen_size.position.x:
			velocity.x = 0 if direction < 0 else velocity.x
			state = STATE_ON_WALL
	move_and_slide()
	#get_parent().queue_redraw()
func _process(_delta: float) -> void:
	self.queue_redraw()

func _draw() -> void:
	var poly = [] as PackedVector2Array
	
	for i in (get_child_count()):
		var p = get_child(i)
		if p is Polygon2D:
			print("p is clockwise")
			poly = Geometry2D.merge_polygons(
					poly,
					Transform2D(0, p.global_position) * p.polygon
			)
			print("poly: %s" % [poly])
			poly = poly[0] as PackedVector2Array
	DisplayServer.window_set_mouse_passthrough(
		poly
	)

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			holding = event.pressed
	
	if event is InputEventMouseMotion:
		if holding:
			var pos = self.position
			if Geometry2D.is_point_in_polygon(get_viewport().get_mouse_position(),
				Transform2D(0, self.position) * $CollisionPolygon2d.polygon
			):
				self.position = pos + event.relative
			else:
				self.position = pos
			self.velocity = Vector2.ZERO
