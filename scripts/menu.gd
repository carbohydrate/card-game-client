extends Control

var decks_scene = preload("res://scenes/decks.tscn").instantiate()
var game_scene = preload("res://scenes/game.tscn").instantiate()

func _ready():
	$StartGameButton.connect("game_ready", _on_game_ready)
	$StartGameButton.grab_focus()

func _on_decks_button_pressed():
	get_tree().root.add_child(decks_scene)
	self.visible = false

func _on_game_ready():
	get_tree().root.add_child(game_scene)
	queue_free()
