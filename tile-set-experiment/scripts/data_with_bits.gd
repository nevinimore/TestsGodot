extends RefCounted

class_name DataWithBits
## Struct with 
## + Coords: the coord of that tile set on atlas
## + Data: the data of that tile set
## + Peering Bit: The array of int called Peering Bit: 
## +---+ each position represents a boolean with 
##     +---+ The first is the presence of the cell
##     +---+ The second to nineth each neighbour cell from 
##         |    right side in a clockwise direction
##         + The last is the int digit as a flag

var coord:Vector2i = Vector2i(0, 0)
var data:TileData = null
var peering_bit: Array[int] = []

## Constructor of a DataWithBits
static func new_coord_data(a_coord: Vector2i, a_peering_bit: Array[int], a_data: TileData) -> DataWithBits:
	var res := DataWithBits.new()
	res.coord = a_coord
	res.peering_bit = a_peering_bit
	res.data = a_data
	return res


func str() -> String:
	return "coord: %s, peering bit: %s" % [coord, peering_bit]
