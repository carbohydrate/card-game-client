extends Control

var decks_scene = preload("res://scenes/decks.tscn").instantiate()

func _ready():
	var testData = State.account_decks
	print(typeof(testData))
	print('testData: ', testData)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_decks_button_pressed():
	get_tree().root.add_child(decks_scene)
	#add_child(decks_scene)
	self.visible = false
	#self.queue_free()
