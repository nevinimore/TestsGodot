extends Node2D

var client_02_scene = preload("res://client_02.tscn")
var client_02_instance: Client02 = null;

var client_03_instance: Client03 = null
var client_04 = null

func _ready():
	client_02_instance = client_02_scene.instantiate()
	add_child(client_02_instance)
	
	test_client_03_instance_from_client_02_instance()


func get_client_02_instance() -> Node2D:
	return client_02_instance

func clean_instance():
	client_02_instance.queue_free()

func test_client_03_instance_from_client_02_instance():
	print("testing client_03_instance_from_client_02_instance")
	
	print("------------------------------------------------------------")
	
	print("before get: client 03 instance: " + str(client_03_instance))
	client_03_instance = client_02_instance.get_client_03_instance()
	print("after get: client 03 instance: " + str(client_03_instance))
	
	print("------------------------------------------------------------")
	
	print("before get_client_04(): client 04: " + str(client_04))
	client_04 = client_03_instance.get_client_04()
	print("after get_client_04(): client 04: " + str(client_04))
	
	print("------------------------------------------------------------")
	
	print("before clean: client 03 instance: " + str(client_03_instance))
	print("              client 04: " + str(client_04))
	clean_instance()
	print("after clean: client 03 instance: " + str(client_03_instance))
	print("             client 04: " + str(client_04))
	
	print("------------------------------------------------------------")
	
	print("before wait: client 03 instance: " + str(client_03_instance))
	print("             client 04: " + str(client_04))
	await(get_tree().create_timer(0.5).timeout)
	print("after  wait: client 03 instance: " + str(client_03_instance))
	print("             client 04: " + str(client_04))
	
	print("------------------------------------------------------------")
	
	print("is freed object null? " + str(client_03_instance==null))




