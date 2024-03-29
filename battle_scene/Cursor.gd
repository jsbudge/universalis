# Supports both keyboard and mouse (or touch) input.
# The `tool` mode allows us to preview the drawing code you'll see below in the editor.
class_name Cursor
extends Node2D

# We'll use signals to keep the cursor decoupled from other nodes.
# When the player moves the cursor or wants to interact with a cell, we emit a signal and let
# another node handle the interaction.

# Emitted when clicking on the currently hovered cell or when pressing "ui_accept".
signal accept_pressed(cell)
# Emitted when the cursor moved to a new cell.
signal moved(new_cell)

# Grid resource, giving the node access to the grid size, and more.
@export var grid: Resource = preload("res://battle_scene/battledata.tres")
# Time before the cursor can move again in seconds.
# You can see how we use it in the unhandled input function below.
@export var ui_cooldown := 0.1

# Coordinates of the current cell the cursor is hovering.
var cell := Vector2.ZERO
var homecell := Vector2.ZERO
var constraint: int = 1
var constrain: bool = false

# Type of rect to draw around cursor.
var rect_type: int = 0

# We use the timer to have a cooldown on the cursor movement.
@onready var _timer: Timer = $Timer


# When the cursor enters the scene tree, we snap its position to the centre of the cell and we
# initialise the timer with our ui_cooldown variable.
func _ready() -> void:
	_timer.wait_time = ui_cooldown
	position = grid.calculate_map_position(cell)
	visible = false


func _unhandled_input(event: InputEvent) -> void:
	# If the user moves the mouse, we capture that input and update the node's cell in priority.
	if event is InputEventMouseMotion:
		self.cell = grid.calculate_grid_coordinates(event.position)
	# If we are already hovering the cell and click on it, or we press the enter key, the player
	# wants to interact with that cell.
	elif event.is_action_pressed("click") or event.is_action_pressed("ui_accept"):
		#  In that case, we emit a signal to let another node handle that input. The game board will
		#  have the responsibility of looking at the cell's content.
		emit_signal("accept_pressed", cell)

	# The code below is for the cursor's movement.
	# The following lines make some preliminary checks to see whether the cursor should move or not
	# if the user presses an arrow key.
	var should_move := event.is_pressed()
	# If the player is pressing the key in this frame, we allow the cursor to move. If they keep the
	# keypress down, we only want to move after the cooldown timer stops.
	if event.is_echo():
		should_move = should_move and _timer.is_stopped()

	# And if the cursor shouldn't move, we prevent it from doing so.
	if not should_move:
		return

	# Here, we update the cursor's current cell based on the input direction. See the set_cell()
	# function below to see what changes that triggers.
	var direction = Vector2.ZERO
	if event.is_action("ui_right"):
		direction = Vector2.RIGHT
	elif event.is_action("ui_up"):
		direction = Vector2.UP
	elif event.is_action("ui_left"):
		direction = Vector2.LEFT
	elif event.is_action("ui_down"):
		direction = Vector2.DOWN
	if constrain:
		if homecell.distance_to(cell + direction) > constraint:
			return
	set_cell(cell + direction)


# We use the draw callback to a rectangular outline the size of a grid cell, with a width of two
# pixels.
func _draw() -> void:
	# Rect2 is built from the position of the rectangle's top-left corner and its size. To draw the
	# square around the cell, the start position needs to be `-grid.cell_size / 2`.
	draw_rect(Rect2(-grid.cell_size / 2 - rect_type * grid.cell_size / 2, 
	grid.cell_size + rect_type * grid.cell_size), Color.ALICE_BLUE, false, 2.0)


# This function controls the cursor's current position.
func set_cell(value: Vector2) -> void:
	# We first clamp the cell coordinates and ensure that we weren't trying to move outside the
	# grid's boundaries.
	var new_cell: Vector2 = grid.clamp(value)
	if new_cell.is_equal_approx(cell):
		return

	cell = new_cell
	# If we move to a new cell, we update the cursor's position, emit a signal, and start the
	# cooldown timer that will limit the rate at which the cursor moves when we keep the direction
	# key down.
	position = grid.calculate_map_position(cell)
	emit_signal("moved", cell)
	_timer.start()
	
func set_rect(value: int) -> void:
	rect_type = value - 1


func _on_battle_ui_select(range, aoe):
	homecell = cell
	constraint = range
	set_rect(aoe)
	constrain = true
	visible = true


func _on_game_scene_next_action():
	constrain = false # Replace with function body.


func _on_visibility_changed():
	$AnimationPlayer.play()
