extends Spatial
#https://www.youtube.com/watch?v=HRfqnxPm66Y
var tile = preload("res://Level_Gen/SimpleTile.fbx_Collection/Tiles_V2.tscn")
var noise
var rng
var map_size = 50
var map_height = 1
var water_level = 0.015
const dir = [Vector2.RIGHT, Vector2.LEFT, Vector2.UP, Vector2.DOWN]

func _init():
	if !rng:
		rng = RandomNumberGenerator.new()
	noise = OpenSimplexNoise.new()
	noise.seed = rng.randi()
	noise.octaves = 3
	noise.period = 3.0
	noise.persistence = 0.5
	
func _ready():
	rng.randomize()
	noise.seed = rng.randi()
	var val
	var walls = [0,0,0,0]
	for x in range(-map_size,map_size):
		for y in range(0,map_height):
			for z in range(-map_size,map_size):
				val = noise.get_noise_3d(x,y,z)
				if $GridMap.get_cell_item(x,y,z) == -1:
					if noise.get_noise_3d(x,y,z) < water_level:
						$GridMap.set_cell_item(x,y,z,0)
					else:
						$GridMap.set_cell_item(x,y,z,4)
	
	var pos = $player.translation
	print(pos)
	pos = $GridMap.world_to_map(pos)
	print(pos)
	var cell = $GridMap.get_cell_item(pos.x,pos.y-2,pos.z)
	print(cell)
	if cell == 4 or cell == -1 :
		$player.transform.origin =pos+Vector3(0,10,0)
		print(pos+Vector3(0,100,0))
		
# Place tile

