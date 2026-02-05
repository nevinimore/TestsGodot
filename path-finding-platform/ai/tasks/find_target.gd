extends BTAction

@export var group: StringName = &"group"
@export var target_var: StringName = &"target"

var target: CharacterBody2D = null

func _enter():
	target = get_player_node()
	print(agent, " has found " , target)
	blackboard.set_var(target_var, target)

func _tick(_delta: float) -> Status:
	return SUCCESS

func get_player_node():
	var nodes: Array[Node] = agent.get_tree().get_nodes_in_group(group)
	var player = nodes[0]
	return player
	