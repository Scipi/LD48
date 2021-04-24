extends Spatial
#https://www.youtube.com/watch?v=HRfqnxPm66Y
var tile = preload("res://Level_Gen/Tiles.tscn")
var rng
const dir = [Vector2.RIGHT, Vector2.LEFT, Vector2.UP, Vector2.DOWN]

func _init():
	pass
	
func _ready():
	pass
	
func _physics_process(delta):
	var pos = $player.get_translation()
	print($GridMap.get_cell_item(pos.x,0,pos.y))
	
#	# Place tile
