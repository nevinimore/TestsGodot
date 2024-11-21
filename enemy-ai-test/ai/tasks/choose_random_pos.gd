extends BTAction

@export var min_pos := 30
@export var max_pos := 50

@export var position_var: StringName = &"pos"
@export var dir_var: StringName = &"dir"


func _tick(_delta) -> Status:
	
	var pos: Vector2
	var dir = rando_dir()
	
	return SUCCESS

	
func rando_dir() -> int:
	var dir = randi_range(0, 1)*2-1
	blackboard.set_var(dir_var, dir)
	return dir
	
	