extends BTAction

@export var target_pos_var: StringName = &"pos"
@export var dir_var: StringName = &"dir"

@export var speed := 40
@export var tolerance := 10

func _tick(_delta: float) -> Status:
	var target_pos: Vector2i = blackboard.get_var(target_pos_var, Vector2i.ZERO)
	var dir: int = blackboard.get_var(dir_var, 0)
	agent.move(dir, speed)
	
	if abs(agent.global_position.x - target_pos.x) < tolerance:
		agent.move(dir, 0)
		return SUCCESS
	else:
		agent.move(dir, speed)
		return RUNNING
