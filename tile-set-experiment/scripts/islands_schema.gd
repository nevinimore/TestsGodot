extends RefCounted

class_name IslandsSchema
## Struct of islands schema
## 
## + islands_schema: map each start to a size
## 

var islands_starts: Dictionary[int, int] = {}
## maps islands starts on to its non islands neighbours (start-1 and start+size+1)
var islands_neighbours: Dictionary[int, Array] = {}

## Constructor of a DataWithBits
static func new_island_schema(peering_bit: Array[int]) -> IslandsSchema:
	return peering_bit_cohesion(peering_bit)

func add(a_start: int, a_size: int):
	islands_starts[a_start] = a_size

func size()->int: 
	return islands_starts.size()

func get_island_neighbours() -> Dictionary[int, Array]:
	if islands_neighbours.size()==0 and not size()==0:
		init_neighbours()
	return islands_neighbours
	

func get_all_neighbours() -> Array[int]:
	var result: Array[int]
	var neighbours:=get_island_neighbours()
	for a_start in neighbours:
		result.append_array(neighbours[a_start])
	return result

func get_all_neighbours_coords(center: Vector2i) -> Array[Vector2i]:
	return []

## return the cohesion of neighbours: 
## return an island schema of peering_bit
static func peering_bit_cohesion(peering_bit: Array) -> IslandsSchema:
	var result:= IslandsSchema.new()
	
	var first_start: int = where_first_island_starts(peering_bit)
	if first_start == 0:
		result.add(0, 8)
		return result
	if first_start == -1:
		return result
	
	var in_island := true
	var last_start := first_start
	for i in range(first_start, first_start + Utils.cell_neighbors.size() - 1):
		var i_mod: int = i%Utils.cell_neighbors.size()
		if i >= Utils.cell_neighbors.size():
			i_mod += 1 ## the first position (0) is not part of neighbour, is the own cell
		
		if in_island:
			if peering_bit[i_mod] == 1:
				continue
			else:
				in_island = false
				var a_size:int = i_mod - last_start
				if a_size < 0:
					a_size = i_mod-1 + (9 - last_start)
				result.add(last_start, a_size)
		else:
			if peering_bit[i_mod] == 1:
				last_start = i_mod
				in_island = true
			else:
				pass
		
	return result


## return where the first island starts: 
## -1 if there is no island
## 0 if its all island
static func where_first_island_starts(peering_bit: Array) -> int:
	var in_island:= false 
	
	if peering_bit[1]==1:
		in_island = true
	
	for i in range(2, Utils.cell_neighbors.size()):
		if not in_island:
			if peering_bit[i]==1:
				return i
			else:
				continue
		else:
			if peering_bit[i]==1:
				continue
			else:
				in_island = false
	
	## if the island begins in 1
	if not in_island and peering_bit[1]==1:
		return 1
	
	## if its all island 
	if in_island:
		return 0
	else: ## if none is island
		return -1


func init_neighbours():
	pass

static func get_neighbours_of_island(a_start: int, a_size: int) -> Array[int]:
	var a_final := a_start + a_final
	
	return [ns, nf]


func str() -> String:
	var res: String = ""
	res += "there is : %s islands\n" % [size()]
	
	for a_start in islands_starts:
		var a_size: int = islands_starts[a_start]
		res += "\tisland %s with size %s\n" % [a_start, a_size]
	
	return res + "\n"
