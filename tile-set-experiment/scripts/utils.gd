extends Node


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


# return peering bit as a flag AND the last as an int
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

	
