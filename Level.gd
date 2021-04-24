extends Spatial
class_name Dungeon_Floor

var lvl:int = 0;
var spawnrate:float = 1.0;
var artifactID:float;
var cleared:bool;

func _init(lvl:int):
	self.artifactID = Run.rng.rand(0,Artifacts.list.max)
	self.cleared = false
	self.lvl = lvl

func _ready():
	if self.cleared == null:
		self.spawnrate -= 0.2
