extends TileMapLayer

class_name CoarseTileMap

var map_digit_to_tile: Dictionary[int, DataWithBits] = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	
	for source_id in range(tile_set.get_source_count()):
		var atlas_source:TileSetAtlasSource = tile_set.get_source(source_id)
		print(atlas_source.get_atlas_grid_size())
		var grid_size: Vector2i = atlas_source.get_atlas_grid_size()
		var tiles_coords: Array[Vector2i] = []
		for x in range(grid_size.x):
			for y in range(grid_size.y):
				var coords:Vector2i = Vector2(x, y)
				if atlas_source.has_tile(coords):
					tiles_coords.append(coords)
		
		for coord in tiles_coords:
			print(coord)
			var data: TileData = atlas_source.get_tile_data(coord, 0)
			var flag:Array[int] = Utils.data_to_peering_bit_flag(data)
			map_digit_to_tile[flag[-1]] = DataWithBits.new_coord_data(coord, flag, data)
			
		var missing_map_digit_to_tile: Dictionary[int, DataWithBits] = {}
		for k in range(2**9):
			if not k in map_digit_to_tile.keys(): # for every possibility not painted
				# if the cell itself is not painted, 
				# In this mode there will be no empty cell
				if k % 2 == 0: 
					continue
				else: # if its painted it will be the closest terrain
					#print(k, " (",Utils.int_to_peering_bit_flag(k),") ", " is missing")
					missing_map_digit_to_tile[k] = closest_from_digit(k)
					#print("closest: ", missing_map_digit_to_tile[k].coord)
					#print(k, " (",missing_map_digit_to_tile[k].peering_bit,") ", " is the replacement")
		
		# Trying to not use missing
		#for k in missing_map_digit_to_tile.keys():
			#map_digit_to_tile[k] = missing_map_digit_to_tile[k]
		
		#for k in range(2**9):
			#print(map_digit_to_tile[k].str())
		
		#for terrains_set in tile_set.get_terrain_sets_count():
			#for terrain_index in tile_set.get_terrains_count(terrains_set):
				#print(tile_set.get_terrain_color(terrains_set, terrain_index))
				#print(tile_set.get_terrain_name(terrains_set, terrain_index))
	
	
	# set of used cells with peering bit
	var used_cells: Dictionary[Vector2i, Array] = {}
	# set of non used cells but neighbours
	var non_used_neighbours: Dictionary[Vector2i, Array] = {}
	for cell in get_used_cells():
		used_cells[cell] = []
		for cell_add in Utils.coord_neighbors:
			var cell_neighbour = cell+cell_add
			if get_cell_source_id(cell_neighbour) == -1:
				used_cells[cell].append(0)
				# Also, use the loop to update that non used cell
				if not cell_neighbour in non_used_neighbours.keys():
					var non_used_cell:Vector2i = cell_neighbour
					non_used_neighbours[cell_neighbour] = []
					for non_used_cell_add in Utils.coord_neighbors:
						var non_used_cell_neighbour = non_used_cell+non_used_cell_add
						var has_cell := get_cell_source_id(non_used_cell_neighbour) != -1
						non_used_neighbours[cell_neighbour].append(1 if has_cell else 0)
			else:
				used_cells[cell].append(1)
		
	print("Used cells")
	var used_cells_candidate: Dictionary[Vector2i, DataWithBits] = {}
	for cell in used_cells.keys():
		print("cell: ", cell)
		print("neighbours: ", used_cells[cell])
		print("tile data: ", get_cell_tile_data(cell))
		print("source id: ", get_cell_source_id(cell))
		print("atlas coords: ", get_cell_atlas_coords(cell))
		print("local to map: ", local_to_map(cell))
		print("map to local: ", map_to_local(cell))
		var digit: int = Utils.peering_bit_flag_to_int(used_cells[cell])
		print("digit: ", digit)
		used_cells_candidate[cell] = map_digit_to_tile[digit]
		var new_cell_atlas_coord := map_digit_to_tile[digit].coord
		print("putting another cell: ", map_digit_to_tile[digit].str())
		print("putting another cell: ", new_cell_atlas_coord)
		set_cell(cell, 0, map_digit_to_tile[digit].coord, 0)
		print("---------------------------")
	
	print("Non used cells")
	for cell in non_used_neighbours.keys():
		print("cell: ", cell)
		print("neighbours: ", non_used_neighbours[cell])
		print("tile data: ", get_cell_tile_data(cell))
		print("source id: ", get_cell_source_id(cell))
		print("atlas coords: ", get_cell_atlas_coords(cell))
		print("local to map: ", local_to_map(cell))
		print("map to local: ", map_to_local(cell))
		var digit: int = Utils.peering_bit_flag_to_int(non_used_neighbours[cell])
		print("digit: ", digit)
		used_cells_candidate[cell] = map_digit_to_tile[digit]
		var new_cell_atlas_coord := map_digit_to_tile[digit].coord
		print("putting another cell: ", map_digit_to_tile[digit].str())
		print("putting another cell: ", new_cell_atlas_coord)
		set_cell(cell, 0, map_digit_to_tile[digit].coord, 0)
		print("---------------------------")
		print("")
	
	set_cell(Vector2i(0, 0), 0, Vector2i(0, 0), 0)
	
	

# the closest terrain is that have most bits in commom, if drawn, that with less bits wins
func closest_from_digit(digit: int) -> DataWithBits:
	
	var peering_bit := Utils.int_to_peering_bit_flag(digit)
	
	var min_dist := 2**9 # just a high number
	var min_data := DataWithBits.new()
	
	for k in map_digit_to_tile.keys():
		var this_dist: int = Utils.dist(peering_bit, map_digit_to_tile[k].peering_bit)
		if this_dist == min_dist:
			min_data = Utils.less_bit(map_digit_to_tile[k], min_data)
		elif this_dist < min_dist:
			min_dist = this_dist
			min_data = map_digit_to_tile[k]
		
	return min_data
		
