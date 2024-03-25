extends Control

var resource_icon_scene = preload('res://scenes/resource_icon.tscn').instantiate()

func _ready():
	$ResourceIconContainer.add_child(resource_icon_scene)
