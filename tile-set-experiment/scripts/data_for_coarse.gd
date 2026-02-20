extends DataWithBits

class_name DataForCoarse
## Struct extends DataWithBits and has islands schema
## 
## + islands_beginins: an int array each position is the begining of an island
## + islands_size: an int array each position is the size of an island
## 

var islands_begin: Array[int] = []
var islands_size: Array[int] = []

## Constructor of a DataWithBits
static func new_coord_data(a_coord: Vector2i, a_peering_bit: Array[int], a_data: TileData) -> DataForCoarse:
	var res := super.new_coord_data(a_coord, a_peering_bit, a_data)
	return res
