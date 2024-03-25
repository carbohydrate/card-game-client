extends Node2D

@export var game_drop_zone_distance: int = 200

func _ready():
	$Card.connect("selection_dropped", _on_selection_dropped)

func _on_selection_dropped(card: Node2D):
	var distance = card.position.distance_to($GameDropZone.position)
	if distance < game_drop_zone_distance:
		# play card
		card.global_position = $PlayZone.position
	else:
		# return card to hand
		card.global_position = $HandDropZone.position
