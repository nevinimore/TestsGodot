extends Node


@warning_ignore("int_as_enum_without_cast")
@warning_ignore("int_as_enum_without_match")
var cell_neighbors: Array[TileSet.CellNeighbor] = [
		-1, # the own cell
		TileSet.CELL_NEIGHBOR_RIGHT_SIDE, 
		TileSet.CELL_NEIGHBOR_BOTTOM_RIGHT_CORNER, 
		TileSet.CELL_NEIGHBOR_BOTTOM_SIDE, 
		TileSet.CELL_NEIGHBOR_BOTTOM_LEFT_CORNER, 
		TileSet.CELL_NEIGHBOR_LEFT_SIDE, 
		TileSet.CELL_NEIGHBOR_TOP_LEFT_CORNER, 
		TileSet.CELL_NEIGHBOR_TOP_SIDE, 
		TileSet.CELL_NEIGHBOR_TOP_RIGHT_CORNER, 
]

var coord_neighbors: Array[Vector2i] = [
		Vector2i( 0,  0), 
		Vector2i( 1,  0), 
		Vector2i( 1,  1), 
		Vector2i( 0,  1), 
		Vector2i(-1,  1), 
		Vector2i(-1,  0), 
		Vector2i(-1, -1), 
		Vector2i( 0, -1), 
		Vector2i( 1, -1), 
]


## return peering bit as a flag AND the last as an int
func data_to_peering_bit_flag(data: TileData) -> Array[int]:
	var res_flag: Array[int] = []
	var res_int: int = 0
	for i in range(cell_neighbors.size()):
		var value:int = 0
		if i==0: # the first value is the cell itself
			value = data.terrain
		else:
			value = data.get_terrain_peering_bit(cell_neighbors[i])
		value+=1 # peering bit gives -1 for not and 0 for yes
		res_flag.append(value)
		res_int+=value*(2**i)
	res_flag.append(res_int)  # append the int for optimization
	
	return res_flag

## return peering bit as a flag AND the last as an int
func int_to_peering_bit_flag(digit: int) -> Array[int]:
	var og_digit: int = digit
	var res_flag: Array[int] = []
	
	for i in range(cell_neighbors.size()):
		res_flag.append(digit%2)
		digit/=2
	
	res_flag.append(og_digit)  # append the int for optimization
	return res_flag

	
## return peering bit as just the int
func peering_bit_flag_to_int(peering_bit: Array) -> int:
	var res_int: int = 0
	
	for i in range(cell_neighbors.size()):
		res_int+=peering_bit[i]*2**i
	
	return res_int

## The distance bettween peering bit 1 and 2
## in terms of how many bit are not equal
func dist(p1: Array[int], p2: Array[int]) -> int:
	var res_dist := 0
	for i in range(cell_neighbors.size()):
		res_dist += 1 if p1[i]!=p2[i] else 0 
	return res_dist	
	
## Return the data with less bits
func less_bit(d1: DataWithBits, d2: DataWithBits) -> DataWithBits:
	
	var q1 := 0
	for i in range(cell_neighbors.size()):
		q1 += d1.peering_bit[i]
	
	var q2 := 0
	for i in range(cell_neighbors.size()):
		q2 += d2.peering_bit[i]
	
	return d1 if q1<q2 else d2

 
