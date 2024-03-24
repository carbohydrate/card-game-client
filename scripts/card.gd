extends Node2D

signal selection_dropped(card: Node2D)

var selected: bool = false

func _physics_process(delta):
	if (selected):
		global_position = lerp(global_position, get_global_mouse_position(), 25 * delta)

func _on_area_2d_input_event(_viewport: Node, _event: InputEvent, _shape_idx: int):
	if (Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)):
		selected = true
	elif (not Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) && selected):
		selected = false
		selection_dropped.emit(self)
