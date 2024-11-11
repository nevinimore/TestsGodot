extends Node


func _ready():
	Singleton.sub_viewport_container = $SubViewportContainer
	Singleton.sub_viewport = $SubViewportContainer/SubViewport


