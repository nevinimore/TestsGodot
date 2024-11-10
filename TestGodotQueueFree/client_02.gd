extends Node2D

class_name Client02

var client_03_scene = preload("res://client_03.tscn")
var client_03_instance = null;

func _ready():
	client_03_instance = client_03_scene.instantiate()
	add_child(client_03_instance)


func get_client_03_instance() -> Node2D:
	return client_03_instance
