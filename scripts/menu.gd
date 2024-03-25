extends Control

var decks_scene = preload("res://scenes/decks.tscn").instantiate()
var game_scene = preload("res://scenes/game.tscn").instantiate()

func _ready():
	$StartGameButton.grab_focus()

func _on_decks_button_pressed():
	get_tree().root.add_child(decks_scene)
	#add_child(decks_scene)
	self.visible = false
	#self.queue_free()

func _on_game_ready():
	get_tree().root.add_child(game_scene)
	queue_free()
