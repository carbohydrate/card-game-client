extends Node

var menu_scene = preload("res://scenes/menu.tscn").instantiate()

#func _ready():
	#Networking.connect("connection_failed", _on_connection_failed)

func _on_connect_pressed():
	print('client pressed connect!')
	var http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.request_completed.connect(_on_request_completed)

	var data_to_send = {"username": "kf", "password": "Test_1234"}
	var json = JSON.stringify(data_to_send)
	var url = "http://localhost:3000/session"
	var headers = ["Content-Type: application/json"]
	var error = http_request.request(url, headers, HTTPClient.METHOD_POST, json)
	if error != OK:
		push_error("An error occurred in the HTTP request.")

# Called when the HTTP request is completed.
func _on_request_completed(result, response_code, headers: PackedStringArray, body):
	#print("body: ", body)
	var json = JSON.parse_string(body.get_string_from_utf8())
	print(json['message'])

	var cookie = headers.has('Set-Cookie')
	print("cookie: ", cookie)

func _on_button_2_pressed():
	var http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.request_completed.connect(_on_request_completed)

	var data_to_send = {"username": "kf", "password": "Test_1234"}
	var json = JSON.stringify(data_to_send)
	var url = "http://localhost:3000/account"
	var headers = ["Content-Type: application/json"]
	var error = http_request.request(url, headers, HTTPClient.METHOD_POST, json)
	if error != OK:
		push_error("An error occurred in the HTTP request.")
