extends Node2D

@export var game_drop_zone_distance: int = 200

func _ready():
	$Card.connect("selection_dropped", _on_selection_dropped)
	$GetGameStateHTTPRequest.request_completed.connect(_on_get_game_state_request_completed)
	Networking.get_game_state($GetGameStateHTTPRequest)

func _on_selection_dropped(card: Node2D):
	var distance = card.position.distance_to($GameDropZone.position)
	if distance < game_drop_zone_distance:
		# play card
		card.global_position = $PlayZone.position
	else:
		# return card to hand
		card.global_position = $HandDropZone.position

func _on_get_game_state_request_completed(result: int, response_code: int, _headers: PackedStringArray, body: PackedByteArray):
	if (result == HTTPRequest.RESULT_SUCCESS && response_code == 200):
		var data: Variant = JSON.parse_string(body.get_string_from_utf8())
		State.gameState = data
	else:
		print("something bad happend, unsure what to do?")
