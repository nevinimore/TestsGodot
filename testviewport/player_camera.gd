extends Camera2D

class_name PlayerCamera

var player: Player = null

const game_size := Vector2(160, 90)
@onready var window_scale: float = (DisplayServer.window_get_size().x/game_size.x)
@onready var actual_cam_pos := global_position

func _process(delta: float) -> void:
	if player:
		var mouse_pos:= get_viewport().get_mouse_position()#/window_scale
		print(mouse_pos)
		mouse_pos -= (game_size/2) 
		mouse_pos += player.global_position
		print(mouse_pos)
		
		var cam_pos = lerp(player.global_position, mouse_pos, .7)
		actual_cam_pos = lerp(actual_cam_pos, cam_pos, 5*delta)
		
		var sub_pixel_position:Vector2 = actual_cam_pos.round() - actual_cam_pos
		

		Singleton.sub_viewport_container.material.set_shader_parameter("cam_offset", sub_pixel_position)
		
		global_position = actual_cam_pos.round()



func set_player(a_player: Player):
	player = a_player
	
	
