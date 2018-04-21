extends Node2D

var curmap = Array()
var nextmap = Array()
var HEIGHT = 36
var WIDTH = 63
var sele = Vector2(1000, 1000)

func _ready():
	# Populate map
	randomize()
	for y in range(HEIGHT):
		nextmap.append([])
		nextmap[y].resize(WIDTH)

		curmap.append([])
		curmap[y].resize(WIDTH)

		for x in range(WIDTH):
			nextmap[y][x] = randi()%2
			curmap[y][x] = 0
			
	
func _process(delta):
	for y in range(HEIGHT):
		curmap[y] = nextmap[y].duplicate()
		
	var neigh
	for y in range(HEIGHT):
		for x in range(WIDTH):
			neigh = 0
#			if x == sele[0] and y == sele[1]:
#				sele = Vector2(1000, 1000) # For debug
			if x > 0:
				if curmap[y][x-1] == 1:
					neigh = neigh + 1
			if y > 0:
				if curmap[y-1][x] == 1:
					neigh = neigh + 1
			if x < WIDTH-1:
				if curmap[y][x+1] == 1:
					neigh = neigh + 1
			if y < HEIGHT-1:
				if curmap[y+1][x] == 1:
					neigh = neigh + 1
			if x > 0 and y > 0:
				if curmap[y-1][x-1] == 1:
					neigh = neigh + 1
			if x < WIDTH-1 and y > 0:
				if curmap[y-1][x+1] == 1:
					neigh = neigh + 1
			if x > 0 and y < HEIGHT-1:
				if curmap[y+1][x-1] == 1:
					neigh = neigh + 1
			if x < WIDTH-1 and y<HEIGHT-1:
				if curmap[y+1][x+1] == 1:
					neigh = neigh + 1
			if curmap[y][x] == 1:
				if neigh < 2 or neigh > 3:
					nextmap[y][x] = 0
			else:
				if neigh == 3:
					nextmap[y][x] = 1
				

			$TileMap.set_cell(x, y, curmap[y][x])
	
	
func _input(event):
	if(event.is_action_pressed("ui_accept")):
		sele = $TileMap.world_to_map(event.position)
		nextmap[sele[1]][sele[0]] = 1
	
	if(event.is_action_pressed("ui_cancel")):
		get_tree().change_scene("res://menu.tscn")
