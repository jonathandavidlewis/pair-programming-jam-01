extends Node2D

onready var grid: TileMap = get_node("TileMap")

var tile_background: Resource = load("res://src/BackgroundChunk.tscn")
var camera_pos: Vector2

func _ready() -> void:
	Signals.connect("updated_camera_pos", self, "_on_updated_camera_pos")

func _on_updated_camera_pos(updated_camera_pos) -> void:
	draw_chunks(updated_camera_pos)

func draw_chunks(updated_camera_pos) -> void:
	var tile_bg: Node2D
	var tiles = get_chunks(updated_camera_pos)
	for tile in tiles:
		if grid.get_cell(tile.x, tile.y) == -1:
			grid.set_cell(tile.x, tile.y, 0)
			tile_bg = tile_background.instance()
			tile_bg.global_position = grid.map_to_world(tile)
			add_child(tile_bg)

func get_chunks(updated_camera_pos) -> Array:
	var tiles: Array = []
	var current_tile = grid.world_to_map(updated_camera_pos)
	tiles.push_back(Vector2(current_tile.x + 1, current_tile.y + 1))
	tiles.push_back(Vector2(current_tile.x - 1, current_tile.y + 1))
	tiles.push_back(Vector2(current_tile.x - 1, current_tile.y - 1))
	tiles.push_back(Vector2(current_tile.x + 1, current_tile.y - 1))
	tiles.push_back(Vector2(current_tile.x - 1, current_tile.y))
	tiles.push_back(Vector2(current_tile.x + 1, current_tile.y))
	tiles.push_back(Vector2(current_tile.x, current_tile.y - 1))
	tiles.push_back(Vector2(current_tile.x, current_tile.y + 1))
	return tiles
