extends Node

var menu_scene = preload("res://scenes/menu.tscn").instantiate()

func _ready():
	Networking.connect('connected_to_server_success', _on_connected_to_server_success)
	Networking.connect("connected_to_server_failed", _on_connected_to_server_failed)
	$Connect.grab_focus()

func _on_connect_pressed():
	if $AccountName.text.is_empty():
		$ErrorLabelTimer.start()
		$ErrorLabel.text = "Account name is empty."
		$ErrorLabel.show()
	elif $AccountPassword.text.is_empty():
		$ErrorLabelTimer.start()
		$ErrorLabel.text = "Password is empty."
		$ErrorLabel.show()
	else:
		Networking.on_connect_pressed($AccountName.text, $AccountPassword.text)

func _on_connected_to_server_success():
	get_tree().root.add_child(menu_scene)
	self.queue_free()

func _on_connected_to_server_failed(message: String):
	$ErrorLabelTimer.start()
	$ErrorLabel.text = message
	$ErrorLabel.show()

func _on_error_label_timer_timeout():
	$ErrorLabel.hide()
