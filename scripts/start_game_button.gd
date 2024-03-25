extends Button

func _on_pressed():
	$StartGameHTTPRequest.request_completed.connect(_on_start_game_request_completed)
	Networking.on_start_game_pressed($StartGameHTTPRequest)

func _on_start_game_request_completed(result: int, response_code: int, _headers: PackedStringArray, body: PackedByteArray):
	var data: Variant = JSON.parse_string(body.get_string_from_utf8())
	# 202, no other players here yet...
	if (result == HTTPRequest.RESULT_SUCCESS && response_code == 202):
		State.gameId = data.gameId
		$StartGameTimer.start()
	# 200, game found, start game
	elif (result == HTTPRequest.RESULT_SUCCESS && response_code == 200):
		State.gameId = data.gameId


func _on_start_game_timer_timeout():
	$StartGameRetryHTTPRequest.request_completed.connect(_on_start_game_retry_request_completed)
	Networking.on_start_game_timer_timeout($StartGameRetryHTTPRequest)

func _on_start_game_retry_request_completed(result: int, response_code: int, _headers: PackedStringArray, _body: PackedByteArray):
	print("_on_start_game_retry_request_completed: ", response_code)
	# player found, join game
	if (result == HTTPRequest.RESULT_SUCCESS && response_code == 200):
		pass
	# no player yet, retry
	elif (result == HTTPRequest.RESULT_SUCCESS && response_code == 204):
		$StartGameTimer.start()
