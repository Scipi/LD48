extends Node
class_name Run

var rng = RandomNumberGenerator.new()
var run_Seed;
var lvls;
var spawn_mult;
var spawn_dec;
var health_mult;
var armor_mult;
var dam_mult;
var level_mult;

var cur_run = "user://run.save"

func _init(mult,dec,hmult,dmult,amult,lmult):
	self.spawn_mult = mult or 1
	self.spawn_dec = dec or 0
	self.health_mult = hmult or 1
	self.dam_mult = dmult or 1
	self.armor_mult = amult or 1
	self.level_mult = lmult or 1


func _ready():
	rng.randomize()
	var run_Seed = rng.get_seed()
	
	for i in range(0,10):
		if i == 0:
			#lvls[i] = Town.new()
			pass
		else:
			lvls[i] = Dungeon_Floor.new(i)

func save_to_file(cur_seed:int):
	var file = File.new()
	file.open(cur_run, File.WRITE)
	file.store_var(lvls, true)
	file.close()


func load_from_file():
	var file = File.new()
	if file.file_exists(score_file):
		file.open(cur_run, File.READ)
		c = file.get_var(true)
		file.close()
