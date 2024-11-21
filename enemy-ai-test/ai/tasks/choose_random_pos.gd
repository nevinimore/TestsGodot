extends BTAction

@export var min_pos := 30
@export var max_pos := 50

@export var position_var: StringName = &"pos"
@export var dir_var: StringName = &"dir"


func _tick(_delta) -> Status:
	
	var pos: Vector2i
	var dir := rando_dir()
	
	pos = rando_pos(dir)
	print(dir, "   ", pos, "    ", agent.global_position)
	
	return SUCCESS

	
func rando_pos(dir) -> Vector2i:
	var vector: Vector2i
	var distance = randi_range(min_pos, max_pos) * dir
	var final_pos = (distance + agent.global_position.x)
	vector.x = final_pos
	vector.y = agent.global_position.y
	blackboard.set_var(position_var, vector)
	return vector
	
	
func rando_dir() -> int:
	var dir = randi_range(0, 1)*2-1
	blackboard.set_var(dir_var, dir)
	return dir
	
	