extends Node

signal connected_to_server_success
signal connected_to_server_failed(message: String)

const SERVER_IP = '127.0.0.1'
#const SERVER_IP = '172.232.7.60'
const PORT = 3000

var session = ''

func on_connect_pressed(accountName: String, accountPass: String):
	var http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.request_completed.connect(_on_connect_pressed_completed)

	var data_to_send = {
		'username': accountName,
		'password': accountPass,
	}
	#print(get_type(data_to_send))
	var json = JSON.stringify(data_to_send)
	var url = 'http://localhost:3000/session'
	var headers = ['Content-Type: application/json']
	var error = http_request.request(url, headers, HTTPClient.METHOD_POST, json)
	if error != OK:
		push_error('An error occurred in the HTTP request.')

func _on_connect_pressed_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray):
	var data: Variant = JSON.parse_string(body.get_string_from_utf8())

	if (result == HTTPRequest.RESULT_SUCCESS && response_code == 200):
		for h in headers:
			if h.to_lower().begins_with('set-cookie'):
				session = h.split(':', true, 1)[1].strip_edges().split('; ')[0]
				print("session: ", session)
				State.session = session
				State.playerId = data.playerId
				State.account_decks = data.decks
				connected_to_server_success.emit()
	else:
		connected_to_server_failed.emit(data['message'])

func on_start_game_pressed(http_request: HTTPRequest):
	var data_to_send = {
		"playerId": State.playerId,
	}

	var json = JSON.stringify(data_to_send)
	var url = "http://localhost:3000/game/start"
	var headers = ["Content-Type: application/json", "Cookie: %s" % State.session]
	var error = http_request.request(url, headers, HTTPClient.METHOD_POST, json)
	if error != OK:
		push_error("An error occurred in the HTTP request.")

func on_start_game_timer_timeout(http_request: HTTPRequest):
	var url = "http://localhost:3000/game/start/%s" % State.gameId
	var headers = ["Cookie: %s" % State.session]
	var error = http_request.request(url, headers, HTTPClient.METHOD_GET)
	if error != OK:
		push_error("An error occurred in the HTTP request.")
