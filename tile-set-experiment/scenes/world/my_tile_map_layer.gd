extends TileMapLayer

var map_intflag_to_tile: Dictionary[int, Vector2i] = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in get_used_cells():
		print(i)
		print(get_cell_tile_data(i))
		print(get_cell_source_id(i))
		print(get_cell_atlas_coords(i))
		print(local_to_map(i))
		print(map_to_local(i))
	print(tile_set)
	var i := Vector2i(-1, -1)
	print(i)
	print(get_cell_tile_data(i))
	print(get_cell_source_id(i))
	print(get_cell_atlas_coords(i))
	print(local_to_map(i))
	print(map_to_local(i))
	
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
			map_intflag_to_tile[flag[-1]] = coord
			
		for k in range(2**9):
			if not k in map_intflag_to_tile.keys(): # for every possibility not painted
				if k%2 == 0: # if the cell itself is not painted,
					map_intflag_to_tile[k] = map_intflag_to_tile[0] # it will be empty
				else: # if its painted it will be the solo terrain
					map_intflag_to_tile[k] = map_intflag_to_tile[1]
			print(k, map_intflag_to_tile[k])
		
		for terrains_set in tile_set.get_terrain_sets_count():
			for terrain_index in tile_set.get_terrains_count(terrains_set):
				print(tile_set.get_terrain_color(terrains_set, terrain_index))
				print(tile_set.get_terrain_name(terrains_set, terrain_index))
		
		var data: TileData = atlas_source.get_tile_data(Vector2i(0, 0), 0)
		print(data.terrain_set)
		print(data.terrain)
		print(data.get_terrain_peering_bit(TileSet.CELL_NEIGHBOR_RIGHT_SIDE))
		print(data.get_terrain_peering_bit(TileSet.CELL_NEIGHBOR_BOTTOM_RIGHT_CORNER))
		print(data.get_terrain_peering_bit(TileSet.CELL_NEIGHBOR_BOTTOM_SIDE))
		print(data.get_terrain_peering_bit(TileSet.CELL_NEIGHBOR_BOTTOM_LEFT_CORNER))
		print(data.get_terrain_peering_bit(TileSet.CELL_NEIGHBOR_LEFT_SIDE))
		print(data.get_terrain_peering_bit(TileSet.CELL_NEIGHBOR_TOP_LEFT_CORNER))
		print(data.get_terrain_peering_bit(TileSet.CELL_NEIGHBOR_TOP_SIDE))
		print(data.get_terrain_peering_bit(TileSet.CELL_NEIGHBOR_TOP_RIGHT_CORNER))
		
		print(Utils.data_to_peering_bit_flag(data))
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
